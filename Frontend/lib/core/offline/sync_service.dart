import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../network/api_client.dart';
import 'app_database.dart';

/// The offline engine on the device side (SSR Section 11).
///
/// The principle, from §11.1: "Every floor transaction is written there first
/// and shown to the operator immediately. The device then syncs with the server
/// in the background, both ways. The operator is never made to wait for the
/// network, and never has to think about whether it is available."
///
/// So [record] never throws for a network reason and never blocks on one. It
/// writes to the local outbox, returns, and lets the flush loop deal with the
/// server. What the operator sees is the local answer, in well under the one
/// second SSR T-01 allows.
///
/// ---------------------------------------------------------------------------
/// WHAT RUNS WHERE
/// ---------------------------------------------------------------------------
/// The outbox is a native-only database. That is not a limitation being
/// tolerated — §11.2 lists the web portal's work (plan, indent, pick list,
/// reports) as online-only, "acceptable because the office is not on the
/// critical path of the line". The handheld is the offline case, and the
/// handheld is Android.
///
/// On web [db] is null, every call goes straight to the server, and
/// [SyncState.offlineCapable] is false so the UI can say so plainly rather than
/// implying a safety net that is not there.
class MaxionSyncService {
  MaxionSyncService({required ApiClient client, AppDatabase? db, String? deviceId})
      : _client = client,
        _db = db,
        _deviceId = deviceId ?? 'WEB-PORTAL';

  final ApiClient _client;

  /// Null on web, and on a device whose database could not be opened. The
  /// second case is deliberate: a gun that cannot open its own storage can
  /// still work online, and refusing to start would be worse than losing the
  /// queue. Every use below is null-guarded.
  final AppDatabase? _db;

  String _deviceId;
  static const _uuid = Uuid();

  final _statusController = StreamController<SyncState>.broadcast();
  Stream<SyncState> get statusStream => _statusController.stream;

  SyncState _state = const SyncState();
  SyncState get state => _state;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  Timer? _ticker;
  bool _flushing = false;
  bool _started = false;

  bool get offlineCapable => _db != null;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Idempotent. Called on a cold start with a cached session and again after a
  /// later sign-in; without the guard each call would leave an orphaned
  /// connectivity subscription and an extra ticker running for the life of the
  /// process, so every trigger would fire N flushes.
  Future<void> start({String? deviceId}) async {
    if (deviceId != null && deviceId.isNotEmpty) {
      _deviceId = deviceId;
      await _db?.setMeta(AppDatabase.kDeviceId, deviceId);
    } else {
      final stored = await _db?.meta(AppDatabase.kDeviceId);
      if (stored != null && stored.isNotEmpty) _deviceId = stored;
    }

    if (_started) {
      unawaited(flush());
      return;
    }
    _started = true;

    _connectivitySub = Connectivity().onConnectivityChanged.listen((results) {
      final online = _isOnline(results);
      _emit(_state.copyWith(isOnline: online));
      // Coming back into coverage is the moment worth acting on. A gun walking
      // out of a dead aisle should drain before it walks into the next one.
      if (online) unawaited(flush());
    });

    _emit(_state.copyWith(isOnline: await isOnline(), offlineCapable: offlineCapable));

    // A periodic sweep as well as the connectivity trigger, because
    // connectivity_plus reports the radio, not reachability — a gun can be
    // associated to an access point that cannot route to the server.
    _ticker = Timer.periodic(const Duration(seconds: 45), (_) => unawaited(flush()));

    await _refreshCounts();
    unawaited(pull());
    unawaited(flush());
  }

  Future<void> dispose() async {
    await _connectivitySub?.cancel();
    _ticker?.cancel();
    _started = false;
    await _statusController.close();
  }

  static bool _isOnline(List<ConnectivityResult> results) =>
      results.isNotEmpty && !results.every((r) => r == ConnectivityResult.none);

  Future<bool> isOnline() async {
    try {
      return _isOnline(await Connectivity().checkConnectivity());
    } catch (_) {
      // If we cannot tell, assume we are online: an attempt that fails queues
      // the work anyway, whereas assuming offline would queue work that could
      // have been applied at once.
      return true;
    }
  }

  // ---------------------------------------------------------------------------
  // Recording work
  // ---------------------------------------------------------------------------

  /// Record one floor transaction.
  ///
  /// Online and quick, this returns the server's answer and the operator gets
  /// the full result — the pallet number, the running count, the location.
  /// Offline or slow, it queues and returns null, and the caller shows the
  /// "saved, will sync" state instead. Both are successes. Only a rule
  /// rejection — a wrong item, a duplicate wheel — throws, because that is
  /// something the operator must fix now, with the wheel still in their hand.
  ///
  /// The queueing write happens BEFORE the network attempt, so a process killed
  /// mid-request still has the transaction. The clientTxnId makes the re-send
  /// safe if the server did receive the first one.
  Future<Map<String, dynamic>?> record({
    required String txnType,
    required Map<String, dynamic> payload,
    required String onlinePath,
    String? userCode,
  }) async {
    final clientTxnId = _uuid.v4();
    final scannedAt = DateTime.now();

    final db = _db;
    if (db == null) {
      // Web: no outbox, so the server is the only option and a failure is a
      // failure. Nothing is silently lost because nothing was promised.
      final res = await _client.dio.post(onlinePath, data: payload);
      return Map<String, dynamic>.from(res.data as Map);
    }

    final deviceSeq = await db.nextDeviceSeq();
    await db.enqueue(
      clientTxnId: clientTxnId,
      deviceSeq: deviceSeq,
      txnType: txnType,
      payload: payload,
      scannedAt: scannedAt,
      userCode: userCode,
    );
    await _refreshCounts();

    if (!_state.isOnline) {
      unawaited(flush());
      return null;
    }

    try {
      final res = await _client.dio.post(onlinePath, data: payload);
      final status = res.statusCode ?? 0;
      final body = Map<String, dynamic>.from(res.data as Map);

      if (status >= 200 && status < 300) {
        await db.markSynced(clientTxnId, result: body);
        await _refreshCounts();
        return body;
      }

      if (status == 409) {
        await db.markConflict(clientTxnId, error: body['message'] as String?, code: 'CONFLICT');
        await _refreshCounts();
        throw SyncRejection(body['message'] as String? ?? 'This clashes with another device.', isConflict: true);
      }

      // 400 / 404 — a rule said no. Permanent, and the operator needs to know
      // immediately rather than at the end of the shift.
      await db.markConflict(clientTxnId, error: body['message'] as String?, code: 'HTTP_$status');
      await _refreshCounts();
      throw SyncRejection(body['message'] as String? ?? 'Rejected by the server.');
    } on DioException catch (e) {
      // The network, not the rules. It stays queued and the operator carries on.
      await db.markFailed(clientTxnId, error: e.message, code: 'NETWORK');
      await _refreshCounts();
      unawaited(flush());
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Flush
  // ---------------------------------------------------------------------------

  /// Send everything due, in floor order.
  ///
  /// Single-flight: a connectivity change, the ticker and a fresh scan can all
  /// trigger this within a second of each other, and two concurrent batches
  /// would race over the same rows.
  Future<void> flush() async {
    final db = _db;
    if (db == null || _flushing) return;

    _flushing = true;
    _emit(_state.copyWith(isSyncing: true));

    try {
      final due = await db.dueForSync();
      if (due.isEmpty) return;

      await db.markInFlight(due.map((t) => t.clientTxnId).toList());

      final res = await _client.dio.post(
        '/sync/push',
        data: {
          'deviceId': _deviceId,
          'pendingCount': await db.pendingCount(),
          'transactions': due
              .map((t) => {
                    'clientTxnId': t.clientTxnId,
                    'deviceSeq': t.deviceSeq,
                    'txnType': t.txnType,
                    'payload': jsonDecode(t.payload),
                    'scanTime': t.scannedAt.toUtc().toIso8601String(),
                    'userCode': t.userCode,
                  })
              .toList(),
        },
      );

      final status = res.statusCode ?? 0;
      if (status == 503) {
        // The server said its database is unreachable. Keep everything; this is
        // exactly the case the queue exists for.
        for (final t in due) {
          await db.markFailed(t.clientTxnId, error: 'Server database unavailable', code: 'DB_UNAVAILABLE');
        }
        return;
      }
      if (status < 200 || status >= 300) {
        for (final t in due) {
          await db.markFailed(t.clientTxnId, error: 'Server returned $status', code: 'HTTP_$status');
        }
        return;
      }

      await _applyServerVerdict(db, res.data as Map);
      _emit(_state.copyWith(lastSyncTime: DateTime.now(), lastError: null));
    } on DioException catch (e) {
      debugPrint('[maxion-sync] flush failed: ${e.message}');
      _emit(_state.copyWith(lastError: e.message));
    } catch (e) {
      debugPrint('[maxion-sync] flush error: $e');
      _emit(_state.copyWith(lastError: '$e'));
    } finally {
      // Anything the server did not mention would otherwise sit in `inFlight`
      // for ever. Safe to be unscoped because of the single-flight guard.
      await db.releaseInFlight();
      await db.purgeSynced();
      await _refreshCounts();
      _flushing = false;
      _emit(_state.copyWith(isSyncing: false));
    }
  }

  Future<void> _applyServerVerdict(AppDatabase db, Map body) async {
    for (final a in (body['applied'] as List? ?? const [])) {
      final m = Map<String, dynamic>.from(a as Map);
      await db.markSynced(m['clientTxnId'] as String,
          result: m['result'] is Map ? Map<String, dynamic>.from(m['result'] as Map) : null);
    }

    for (final r in (body['rejected'] as List? ?? const [])) {
      final m = Map<String, dynamic>.from(r as Map);
      await db.markConflict(m['clientTxnId'] as String, error: m['reason'] as String?, code: 'REJECTED');
    }

    // SSR §11.3 — these need a supervisor. They leave the automatic loop and
    // show up on the sync screen with both sides of the clash.
    for (final c in (body['conflicts'] as List? ?? const [])) {
      final m = Map<String, dynamic>.from(c as Map);
      await db.markConflict(m['clientTxnId'] as String, error: m['message'] as String?, code: 'CONFLICT');
    }

    // Anything the server refused outright at push — an unknown type, a missing
    // sequence — is a client bug, not a floor event. Mark it so it stops
    // cycling and shows up for someone to look at.
    for (final f in (body['refused'] as List? ?? const [])) {
      final m = Map<String, dynamic>.from(f as Map);
      final id = m['clientTxnId'] as String?;
      if (id != null) await db.markConflict(id, error: m['reason'] as String?, code: 'REFUSED');
    }

    // The whole device can be held behind one unresolved conflict.
    final blocked = body['blockedBy'];
    if (blocked is Map) {
      _emit(_state.copyWith(
        blockedMessage: body['message'] as String? ?? 'Sync is held until a supervisor resolves a conflict.',
      ));
    } else {
      _emit(_state.copyWith(blockedMessage: null));
    }
  }

  // ---------------------------------------------------------------------------
  // Pull
  // ---------------------------------------------------------------------------

  /// Bring down masters, plan and pallet status (SSR §11.1, "BRING DOWN").
  ///
  /// Incremental after the first call of a shift: `since` means a gun on weak
  /// WiFi at the back of the warehouse is not re-downloading the whole item
  /// master every 45 seconds.
  Future<void> pull() async {
    final db = _db;
    if (db == null) return;

    try {
      final since = await db.meta(AppDatabase.kLastPullAt);
      final res = await _client.dio.get('/sync/pull', queryParameters: {
        'deviceId': _deviceId,
        if (since != null) 'since': since,
      });

      if ((res.statusCode ?? 0) != 200) return;
      final body = Map<String, dynamic>.from(res.data as Map);

      final masters = body['masters'];
      if (masters is Map) {
        final items = (masters['items'] as List? ?? const [])
            .map((raw) {
              final m = Map<String, dynamic>.from(raw as Map);
              return CachedItemsCompanion.insert(
                itemCode: (m['itemCode'] ?? '').toString(),
                description: Value(m['description']?.toString()),
                stdPalletQty: Value(_asInt(m['stdPalletQty'] ?? m['standardPalletQty']) ?? 96),
                wheelsPerLayer: Value(_asInt(m['wheelsPerLayer'])),
                stdBoxQty: Value(_asInt(m['stdBoxQty'])),
                channel: Value(m['channel']?.toString()),
              );
            })
            .where((c) => c.itemCode.value.isNotEmpty)
            .toList();
        if (items.isNotEmpty) await db.replaceItems(items);

        final locations = (masters['locations'] as List? ?? const [])
            .map((raw) {
              final m = Map<String, dynamic>.from(raw as Map);
              return CachedLocationsCompanion.insert(
                locationCode: (m['locationCode'] ?? m['code'] ?? '').toString(),
                zone: Value(m['zone']?.toString()),
                locationType: Value((m['locationType'] ?? m['type'])?.toString()),
                capacity: Value(_asInt(m['capacity'])),
              );
            })
            .where((c) => c.locationCode.value.isNotEmpty)
            .toList();
        if (locations.isNotEmpty) await db.replaceLocations(locations);
      }

      final pallets = (body['palletStatus'] as List? ?? const [])
          .map((raw) {
            final m = Map<String, dynamic>.from(raw as Map);
            return CachedPalletsCompanion.insert(
              palletNumber: (m['palletNumber'] ?? '').toString(),
              itemCode: Value(m['itemCode']?.toString()),
              typeSeries: Value(m['typeSeries']?.toString()),
              status: Value(m['status']?.toString()),
              packedQty: Value(_asInt(m['packedQty']) ?? 0),
              locationCode: Value(m['locationCode']?.toString()),
              isHold: Value(m['isHold'] == true),
            );
          })
          .where((c) => c.palletNumber.value.isNotEmpty)
          .toList();
      if (pallets.isNotEmpty) await db.upsertPallets(pallets);

      final serverTime = body['serverTime']?.toString();
      if (serverTime != null) await db.setMeta(AppDatabase.kLastPullAt, serverTime);

      await ensureNumberBlocks();
    } on DioException catch (e) {
      debugPrint('[maxion-sync] pull failed: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Number blocks
  // ---------------------------------------------------------------------------

  /// Top up the reserved number ranges while there is still signal.
  ///
  /// Refilling at a low-water mark rather than on exhaustion is the point: a
  /// gun that runs out mid-aisle cannot close a pallet, and SSR §11.3 would
  /// rather it stopped than minted a number another gun might also mint. The
  /// margin is what keeps that from happening in practice.
  Future<void> ensureNumberBlocks({int lowWaterMark = 50}) async {
    final db = _db;
    if (db == null) return;

    for (final prefix in const ['P', 'H', 'PM']) {
      try {
        final remaining = await db.remainingInBlocks(prefix);
        if (remaining > lowWaterMark) continue;

        final res = await _client.dio.post('/sync/number-block', data: {
          'deviceId': _deviceId,
          'prefix': prefix,
        });
        if ((res.statusCode ?? 0) != 200) continue;

        final block = Map<String, dynamic>.from((res.data as Map)['block'] as Map);
        await db.storeBlock(
          prefix: block['prefix'].toString(),
          blockStart: _asInt(block['blockStart'])!,
          blockEnd: _asInt(block['blockEnd'])!,
          nextValue: _asInt(block['nextValue'])!,
        );
      } on DioException catch (e) {
        debugPrint('[maxion-sync] could not top up $prefix block: ${e.message}');
      }
    }
  }

  /// Mint the next number of a series locally, formatted as SSR §5.1 requires
  /// (prefix + YY + 6 digits). Null when this gun has no block left, which the
  /// caller must surface rather than work around.
  Future<String?> mintNumber(String prefix) async {
    final value = await _db?.takeNumber(prefix);
    if (value == null) return null;
    final yy = DateTime.now().year.toString().substring(2);
    return '$prefix$yy${value.toString().padLeft(6, '0')}';
  }

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  Future<void> _refreshCounts() async {
    final db = _db;
    if (db == null) return;
    _emit(_state.copyWith(pendingCount: await db.pendingCount()));
  }

  void _emit(SyncState next) {
    _state = next;
    if (!_statusController.isClosed) _statusController.add(next);
  }

  /// Used by the sync screen to simulate a dead network during training and
  /// commissioning — SSR §18.3 trains operators on exactly this.
  void setOnline(bool online) => _emit(_state.copyWith(isOnline: online));

  Stream<int> watchPendingCount() => _db?.watchPendingCount() ?? Stream.value(0);
  Stream<List<OutboxTransaction>> watchQueue() => _db?.watchQueue() ?? Stream.value(const []);

  Future<void> retry(int id) async {
    await _db?.retryConflict(id);
    await _refreshCounts();
    unawaited(flush());
  }

  Future<void> discard(int id) async {
    await _db?.discard(id);
    await _refreshCounts();
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }
}

/// A rule said no. Distinct from a network failure, which is never surfaced to
/// the operator because the queue has already dealt with it.
class SyncRejection implements Exception {
  SyncRejection(this.message, {this.isConflict = false});
  final String message;
  final bool isConflict;

  @override
  String toString() => message;
}

/// What the on-screen indicator shows. SSR §11.1 requires it to be always
/// visible: "Green = synced, Amber = pending, Count shown".
@immutable
class SyncState {
  const SyncState({
    this.isOnline = true,
    this.pendingCount = 0,
    this.lastSyncTime,
    this.isSyncing = false,
    this.offlineCapable = false,
    this.lastError,
    this.blockedMessage,
  });

  final bool isOnline;
  final int pendingCount;
  final DateTime? lastSyncTime;
  final bool isSyncing;

  /// False on the web portal, which has no outbox by design (§11.2). The UI
  /// says so rather than implying a safety net that is not there.
  final bool offlineCapable;

  final String? lastError;

  /// Set when the whole device is held behind an unresolved conflict.
  final String? blockedMessage;

  bool get hasPending => pendingCount > 0;
  bool get isBlocked => blockedMessage != null;

  SyncState copyWith({
    bool? isOnline,
    int? pendingCount,
    DateTime? lastSyncTime,
    bool? isSyncing,
    bool? offlineCapable,
    String? lastError,
    String? blockedMessage,
  }) =>
      SyncState(
        isOnline: isOnline ?? this.isOnline,
        pendingCount: pendingCount ?? this.pendingCount,
        lastSyncTime: lastSyncTime ?? this.lastSyncTime,
        isSyncing: isSyncing ?? this.isSyncing,
        offlineCapable: offlineCapable ?? this.offlineCapable,
        lastError: lastError,
        blockedMessage: blockedMessage,
      );
}

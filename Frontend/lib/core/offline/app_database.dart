import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

part 'app_database.g.dart';

/// Where a queued floor transaction is in its life.
///
/// Mirrors the queue in `qr_dispatch_app`, because the problem is the same one:
/// a scan that happened is a fact, and the only question is whether the server
/// has been told about it yet.
enum OutboxStatus {
  /// Waiting to be sent. The flush loop picks this up, and [failed] once its
  /// backoff has elapsed.
  pending,

  /// Handed to the server; the answer has not come back yet.
  inFlight,

  /// Retryable refusal — a timeout, a 5xx, a 503 while the database is down.
  /// Backs off and returns to the loop.
  failed,

  /// The server refused it in a way retrying cannot fix: the same half pallet
  /// claimed on another gun, a pallet already picked, a wheel already on
  /// another pallet. SSR §11.3 is explicit that these "go to a supervisor,
  /// never resolved silently", so this status is a dead end for the automatic
  /// loop by design — a person decides.
  conflict,

  /// Applied by the server. Kept for the rest of the shift so the sync screen
  /// shows what went up rather than silently emptying.
  synced,
}

/// One floor transaction captured on this gun (SSR §11.1).
///
/// This is an OUTBOX, not a cache. The wheel in the operator's hand is the
/// fact; this row is the record of it until the server agrees. Nothing in this
/// table is ever derived from the server.
@DataClassName('OutboxTransaction')
class OutboxTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Minted on this device before the first send and never regenerated. The
  /// server's unique index on (device_id, client_txn_id) turns a second
  /// delivery into "already stored" instead of a second pallet — which is what
  /// makes it safe to re-send a batch whose acknowledgement was lost.
  TextColumn get clientTxnId => text().unique()();

  /// Monotonic per device. The server replays in this order and never in
  /// arrival order, so a putaway can never be applied before the pallet close
  /// it depends on.
  IntColumn get deviceSeq => integer()();

  /// One of the types the server's HANDLERS registry knows — PACK_SCAN_WHEEL,
  /// PALLET_CLOSE, PUTAWAY, PICK_SCAN and so on.
  TextColumn get txnType => text()();

  /// The request body the online call would have sent, as JSON.
  TextColumn get payload => text()();

  /// When it happened on the floor — not when it was sent. SSR §11.3 keeps both
  /// clocks, and this is the one that orders the shift.
  DateTimeColumn get scannedAt => dateTime()();

  /// Badge of the operator, captured at scan time. Guns are shared across a
  /// shift, so the person who did the work is not necessarily the session the
  /// batch travels under.
  TextColumn get userCode => text().nullable()();

  TextColumn get status => textEnum<OutboxStatus>().withDefault(const Constant('pending'))();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  TextColumn get lastErrorCode => text().nullable()();

  /// The server's answer once it arrives, as JSON — the pallet number actually
  /// issued, the location confirmed. Null while queued, because offline the
  /// device genuinely does not know yet.
  TextColumn get serverResult => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Item master, cached so the gun can validate a scan with the network down.
///
/// SSR §11.2 requires wheel scanning, pallet counting and closing to work
/// offline, and all three need the standard pallet quantity. Without this the
/// gun could only record scans blindly and discover at sync that half of them
/// were wrong — which is the failure the whole design exists to avoid.
class CachedItems extends Table {
  TextColumn get itemCode => text()();
  TextColumn get description => text().nullable()();
  IntColumn get stdPalletQty => integer().withDefault(const Constant(96))();
  IntColumn get wheelsPerLayer => integer().nullable()();
  IntColumn get stdBoxQty => integer().nullable()();
  TextColumn get channel => text().nullable()();

  @override
  Set<Column> get primaryKey => {itemCode};
}

/// Storage positions, cached so putaway can suggest and validate offline.
class CachedLocations extends Table {
  TextColumn get locationCode => text()();
  TextColumn get zone => text().nullable()();
  TextColumn get locationType => text().nullable()();
  IntColumn get capacity => integer().nullable()();

  @override
  Set<Column> get primaryKey => {locationCode};
}

/// Pallet status as of the last pull.
///
/// This is what stops a gun offering a pallet it must not touch: one locked by
/// QA, on quality hold, or already reserved for someone else's indent. It is
/// deliberately a thin projection — the gun needs to know what it may do with a
/// pallet, not everything about it.
class CachedPallets extends Table {
  TextColumn get palletNumber => text()();
  TextColumn get itemCode => text().nullable()();
  TextColumn get typeSeries => text().nullable()();
  TextColumn get status => text().nullable()();
  IntColumn get packedQty => integer().withDefault(const Constant(0))();
  TextColumn get locationCode => text().nullable()();
  BoolColumn get isHold => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {palletNumber};
}

/// A range of a number series this device may mint from while offline
/// (SSR §11.3).
///
/// The server hands out disjoint ranges, so two guns working offline at the
/// same time cannot produce the same pallet number. A block is never returned:
/// SSR §5.1 requires numbers never to be reused, so an unused tail is simply
/// burned.
class NumberBlocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get prefix => text()();
  IntColumn get blockStart => integer()();
  IntColumn get blockEnd => integer()();
  IntColumn get nextValue => integer()();
  DateTimeColumn get issuedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get exhausted => boolean().withDefault(const Constant(false))();
}

/// Small key/value store for sync bookkeeping — the device's sequence counter,
/// the last pull timestamp, the work point chosen at login.
class SyncMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [OutboxTransactions, CachedItems, CachedLocations, CachedPallets, NumberBlocks, SyncMeta],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          // WAL, so a scan written from the UI isolate does not block the sync
          // loop reading the queue. On a busy pack point these genuinely
          // overlap — SSR T-01 gives a scan one second to respond.
          await customStatement('PRAGMA journal_mode = WAL');

          // Anything still `inFlight` belongs to a run that was killed
          // mid-send: a battery change, an app restart, Android reclaiming the
          // process. SSR T-10 requires exactly this to be survivable. Those
          // transactions are not lost — they go back in the queue, and the
          // clientTxnId makes a re-send safe even if the server did receive the
          // first attempt.
          await (update(outboxTransactions)..where((t) => t.status.equalsValue(OutboxStatus.inFlight)))
              .write(const OutboxTransactionsCompanion(status: Value(OutboxStatus.pending)));
        },
      );

  static QueryExecutor _open() => driftDatabase(name: 'maxion_dispatch');

  // ---------------------------------------------------------------------------
  // Outbox
  // ---------------------------------------------------------------------------

  /// Reserve the next per-device sequence number.
  ///
  /// Runs in a transaction because two rapid scans must never take the same
  /// sequence — the server orders replay by it, and a tie makes that order
  /// arbitrary at exactly the wrong moment.
  Future<int> nextDeviceSeq() => transaction(() async {
        final row = await (select(syncMeta)..where((t) => t.key.equals(_kDeviceSeq))).getSingleOrNull();
        final next = (int.tryParse(row?.value ?? '0') ?? 0) + 1;
        await into(syncMeta).insertOnConflictUpdate(
          SyncMetaCompanion.insert(key: _kDeviceSeq, value: next.toString()),
        );
        return next;
      });

  /// Queue a transaction. Returns false when this [clientTxnId] is already
  /// queued — a double-tap on the trigger, which must not become two wheels.
  Future<bool> enqueue({
    required String clientTxnId,
    required int deviceSeq,
    required String txnType,
    required Map<String, dynamic> payload,
    required DateTime scannedAt,
    String? userCode,
  }) async {
    try {
      await into(outboxTransactions).insert(
        OutboxTransactionsCompanion.insert(
          clientTxnId: clientTxnId,
          deviceSeq: deviceSeq,
          txnType: txnType,
          payload: jsonEncode(payload),
          scannedAt: scannedAt,
          userCode: Value(userCode),
        ),
      );
      return true;
    } on Exception catch (e) {
      debugPrint('[maxion-db] enqueue rejected (already queued?): $e');
      return false;
    }
  }

  /// The batch to send next: everything pending, plus anything failed whose
  /// backoff has elapsed. Ordered by sequence, because that is the order the
  /// server will replay them in and sending them out of order only delays it.
  Future<List<OutboxTransaction>> dueForSync({int limit = 100}) {
    final now = DateTime.now();
    return (select(outboxTransactions)
          ..where((t) =>
              t.status.equalsValue(OutboxStatus.pending) |
              (t.status.equalsValue(OutboxStatus.failed) &
                  (t.nextAttemptAt.isSmallerOrEqualValue(now) | t.nextAttemptAt.isNull())))
          ..orderBy([(t) => OrderingTerm.asc(t.deviceSeq)])
          ..limit(limit))
        .get();
  }

  Future<void> markInFlight(List<String> clientTxnIds) =>
      (update(outboxTransactions)..where((t) => t.clientTxnId.isIn(clientTxnIds))).write(
        OutboxTransactionsCompanion(
          status: const Value(OutboxStatus.inFlight),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> markSynced(String clientTxnId, {Map<String, dynamic>? result}) =>
      (update(outboxTransactions)..where((t) => t.clientTxnId.equals(clientTxnId))).write(
        OutboxTransactionsCompanion(
          status: const Value(OutboxStatus.synced),
          serverResult: Value(result == null ? null : jsonEncode(result)),
          lastError: const Value(null),
          lastErrorCode: const Value(null),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// A retryable failure. The backoff ladder continues from where it was.
  Future<void> markFailed(String clientTxnId, {String? error, String? code}) async {
    final row = await (select(outboxTransactions)..where((t) => t.clientTxnId.equals(clientTxnId)))
        .getSingleOrNull();
    final attempts = (row?.attempts ?? 0) + 1;
    await (update(outboxTransactions)..where((t) => t.clientTxnId.equals(clientTxnId))).write(
      OutboxTransactionsCompanion(
        status: const Value(OutboxStatus.failed),
        attempts: Value(attempts),
        nextAttemptAt: Value(DateTime.now().add(_backoff(attempts))),
        lastError: Value(error),
        lastErrorCode: Value(code),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// A clash a person has to settle. Leaves attempts and nextAttemptAt alone —
  /// this row is out of the automatic loop until the supervisor acts.
  Future<void> markConflict(String clientTxnId, {String? error, String? code}) =>
      (update(outboxTransactions)..where((t) => t.clientTxnId.equals(clientTxnId))).write(
        OutboxTransactionsCompanion(
          status: const Value(OutboxStatus.conflict),
          lastError: Value(error),
          lastErrorCode: Value(code),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Returns every in-flight row to the queue. Called after each batch, because
  /// anything the server did not echo back would otherwise sit in `inFlight`
  /// for ever.
  Future<void> releaseInFlight() =>
      (update(outboxTransactions)..where((t) => t.status.equalsValue(OutboxStatus.inFlight))).write(
        OutboxTransactionsCompanion(
          status: const Value(OutboxStatus.pending),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> retryConflict(int id) =>
      (update(outboxTransactions)..where((t) => t.id.equals(id))).write(
        OutboxTransactionsCompanion(
          status: const Value(OutboxStatus.pending),
          nextAttemptAt: const Value(null),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> discard(int id) => (delete(outboxTransactions)..where((t) => t.id.equals(id))).go();

  /// "Everything not yet accepted" — what the on-screen indicator counts,
  /// conflicts included. A conflict nobody has dealt with is outstanding work.
  Stream<int> watchPendingCount() {
    final q = selectOnly(outboxTransactions)
      ..addColumns([outboxTransactions.id.count()])
      ..where(outboxTransactions.status.equalsValue(OutboxStatus.synced).not());
    return q.map((r) => r.read(outboxTransactions.id.count()) ?? 0).watchSingle();
  }

  Future<int> pendingCount() async {
    final q = selectOnly(outboxTransactions)
      ..addColumns([outboxTransactions.id.count()])
      ..where(outboxTransactions.status.equalsValue(OutboxStatus.synced).not());
    final row = await q.getSingle();
    return row.read(outboxTransactions.id.count()) ?? 0;
  }

  Stream<List<OutboxTransaction>> watchQueue() => (select(outboxTransactions)
        ..orderBy([
          (t) => OrderingTerm.asc(t.status),
          (t) => OrderingTerm.desc(t.scannedAt),
        ]))
      .watch();

  /// Drops accepted rows older than 12 hours, so the sync screen shows the
  /// shift's history without the table growing without bound.
  Future<int> purgeSynced() => (delete(outboxTransactions)
        ..where((t) =>
            t.status.equalsValue(OutboxStatus.synced) &
            t.updatedAt.isSmallerThanValue(DateTime.now().subtract(const Duration(hours: 12)))))
      .go();

  // ---------------------------------------------------------------------------
  // Cached masters
  // ---------------------------------------------------------------------------

  Future<void> replaceItems(List<CachedItemsCompanion> rows) => transaction(() async {
        await delete(cachedItems).go();
        await batch((b) => b.insertAll(cachedItems, rows));
      });

  Future<void> replaceLocations(List<CachedLocationsCompanion> rows) => transaction(() async {
        await delete(cachedLocations).go();
        await batch((b) => b.insertAll(cachedLocations, rows));
      });

  /// Pallet status is upserted, not replaced: a pull with `since` carries only
  /// what changed, and wiping the table would throw away everything the gun
  /// still needs to know about the rest of the warehouse.
  Future<void> upsertPallets(List<CachedPalletsCompanion> rows) =>
      batch((b) => b.insertAllOnConflictUpdate(cachedPallets, rows));

  Future<CachedItem?> itemByCode(String itemCode) =>
      (select(cachedItems)..where((t) => t.itemCode.equals(itemCode))).getSingleOrNull();

  Future<CachedPallet?> palletByNumber(String palletNumber) =>
      (select(cachedPallets)..where((t) => t.palletNumber.equals(palletNumber))).getSingleOrNull();

  Future<List<CachedLocation>> allLocations() => select(cachedLocations).get();

  /// Half pallets this gun believes are free to top up.
  ///
  /// Advisory, and the UI must say so: the reservation is only confirmed at
  /// sync (SSR §11.2 marks the merge suggestion as working "partly" offline for
  /// exactly this reason). If two guns claim the same one, the first to sync
  /// keeps it and the second operator is told.
  Future<List<CachedPallet>> availableHalfPallets(String itemCode) =>
      (select(cachedPallets)
            ..where((t) =>
                t.itemCode.equals(itemCode) &
                t.typeSeries.equals('H') &
                t.status.equals('STORED_HALF') &
                t.isHold.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.syncedAt)]))
          .get();

  // ---------------------------------------------------------------------------
  // Number blocks
  // ---------------------------------------------------------------------------

  Future<void> storeBlock({
    required String prefix,
    required int blockStart,
    required int blockEnd,
    required int nextValue,
  }) =>
      into(numberBlocks).insert(
        NumberBlocksCompanion.insert(
          prefix: prefix,
          blockStart: blockStart,
          blockEnd: blockEnd,
          nextValue: nextValue,
        ),
      );

  /// Take the next number of a series, or null when this gun has no block left.
  ///
  /// Returning null rather than inventing a number is the point: SSR §11.3 says
  /// a device that cannot record safely should stop, because "it is better to
  /// stop than to lose data" — and a duplicated pallet number is worse than a
  /// paused work point.
  Future<int?> takeNumber(String prefix) => transaction(() async {
        final block = await (select(numberBlocks)
              ..where((t) => t.prefix.equals(prefix) & t.exhausted.equals(false))
              ..orderBy([(t) => OrderingTerm.asc(t.blockStart)])
              ..limit(1))
            .getSingleOrNull();

        if (block == null || block.nextValue > block.blockEnd) {
          if (block != null) {
            await (update(numberBlocks)..where((t) => t.id.equals(block.id)))
                .write(const NumberBlocksCompanion(exhausted: Value(true)));
          }
          return null;
        }

        final value = block.nextValue;
        final advanced = value + 1;
        await (update(numberBlocks)..where((t) => t.id.equals(block.id))).write(
          NumberBlocksCompanion(
            nextValue: Value(advanced),
            exhausted: Value(advanced > block.blockEnd),
          ),
        );
        return value;
      });

  /// How many numbers of a series are left. The sync screen warns on this so a
  /// gun is topped up before a shift rather than during one.
  Future<int> remainingInBlocks(String prefix) async {
    final blocks = await (select(numberBlocks)
          ..where((t) => t.prefix.equals(prefix) & t.exhausted.equals(false)))
        .get();
    return blocks.fold<int>(0, (sum, b) => sum + (b.blockEnd - b.nextValue + 1));
  }

  // ---------------------------------------------------------------------------
  // Meta
  // ---------------------------------------------------------------------------

  Future<String?> meta(String key) async {
    final row = await (select(syncMeta)..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> setMeta(String key, String value) =>
      into(syncMeta).insertOnConflictUpdate(SyncMetaCompanion.insert(key: key, value: value));

  static const _kDeviceSeq = 'deviceSeq';
  static const kLastPullAt = 'lastPullAt';
  static const kDeviceId = 'deviceId';
  static const kWorkPoint = 'workPoint';

  /// Logout. Clears the cached masters and bookkeeping but NOT the outbox —
  /// unsynced floor work belongs to the plant, not to the session, and must
  /// survive a shift handover.
  Future<void> clearSession() => transaction(() async {
        await delete(cachedItems).go();
        await delete(cachedLocations).go();
        await delete(cachedPallets).go();
        await (delete(syncMeta)..where((t) => t.key.isIn([kLastPullAt, kWorkPoint]))).go();
      });

  /// 2s, 5s, 15s, 45s, 2m, 5m — then flat. Fast enough that a brief dead spot
  /// in the aisle resolves before the operator notices, slow enough that a
  /// genuinely down server is not hammered by four guns.
  static Duration _backoff(int attempts) => switch (attempts) {
        <= 1 => const Duration(seconds: 2),
        2 => const Duration(seconds: 5),
        3 => const Duration(seconds: 15),
        4 => const Duration(seconds: 45),
        5 => const Duration(minutes: 2),
        _ => const Duration(minutes: 5),
      };
}

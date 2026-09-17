import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/providers/auth_provider.dart';
import '../offline/app_database.dart';
import '../offline/sync_service.dart';

export '../offline/app_database.dart' show OutboxTransaction, OutboxStatus;
export '../offline/sync_service.dart' show SyncState, SyncRejection, MaxionSyncService;

/// Riverpod wiring for the offline engine (SSR Section 11).
///
/// This file used to BE the engine: a counter that `triggerSync()` set to zero.
/// It is now only the wiring, and the engine lives in core/offline. The two
/// provider names the screens already use — [syncProvider] and its notifier's
/// `triggerSync` / `toggleOnlineStatus` — are kept so nothing had to be
/// rewritten to gain a real queue.

/// The local outbox. Null on web, where there is none by design: SSR §11.2
/// lists the portal's work as online-only, "acceptable because the office is
/// not on the critical path of the line".
///
/// A failure to open is swallowed rather than fatal. A gun that cannot open its
/// own storage can still scan online, and refusing to start would be the worse
/// of the two outcomes on a live shift.
final appDatabaseProvider = Provider<AppDatabase?>((ref) {
  if (kIsWeb) return null;
  try {
    final db = AppDatabase();
    ref.onDispose(db.close);
    return db;
  } catch (e) {
    debugPrint('[maxion] local outbox unavailable, running online-only: $e');
    return null;
  }
});

final syncServiceProvider = Provider<MaxionSyncService>((ref) {
  final service = MaxionSyncService(
    client: ref.watch(apiClientProvider),
    db: ref.watch(appDatabaseProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});

/// The always-on indicator state (§11.1: "Green = synced · Amber = pending ·
/// Count shown").
final syncProvider = StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  return SyncNotifier(ref.watch(syncServiceProvider));
});

class SyncNotifier extends StateNotifier<SyncState> {
  SyncNotifier(this._service) : super(_service.state) {
    _sub = _service.statusStream.listen((s) {
      if (mounted) state = s;
    });
    // Starting here rather than in main() means the engine comes up with the
    // first screen that shows the indicator, and a cold start with a cached
    // session drains yesterday's queue without anyone asking it to.
    unawaited(_service.start());
  }

  final MaxionSyncService _service;
  late final StreamSubscription<SyncState> _sub;

  MaxionSyncService get service => _service;

  /// Send whatever is queued now. The loop would get to it within 45 seconds
  /// anyway; this is the button for an operator who wants to watch it happen.
  Future<void> triggerSync() async {
    await _service.flush();
    await _service.pull();
  }

  /// Simulate a dead network, for training and commissioning (SSR §18.3).
  void toggleOnlineStatus(bool online) => _service.setOnline(online);

  Stream<List<OutboxTransaction>> watchQueue() => _service.watchQueue();

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

/// Scan a location or pallet during picking.
///
/// Web gets the browser camera preview (`..._web.dart`); the handheld gets the
/// gun's hardware trigger (`..._io.dart`). See camera_qr_scanner_dialog.dart for
/// why the two differ.
library;

export 'camera_scanner_dialog_io.dart' if (dart.library.html) 'camera_scanner_dialog_web.dart';

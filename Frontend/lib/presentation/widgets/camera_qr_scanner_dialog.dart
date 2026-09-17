/// Scan a wheel or pallet QR.
///
/// Web gets the browser camera preview (`..._web.dart`); the handheld gets the
/// gun's own scanner (`..._io.dart`). SSR §17 specifies "pistol grip with a
/// hardware trigger", which is both faster and far more reliable in plant
/// lighting than a phone camera reading a small code at 20–60 cm — so on a gun
/// the right thing is to take the trigger's keystrokes, not to open a preview.
///
/// Before this split, the web implementation was imported unconditionally and
/// its `dart:html` import made the Android build impossible.
library;

export 'camera_qr_scanner_dialog_io.dart'
    if (dart.library.html) 'camera_qr_scanner_dialog_web.dart';

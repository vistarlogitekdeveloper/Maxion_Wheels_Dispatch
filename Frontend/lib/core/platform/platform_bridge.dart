/// The browser-only operations this app used to call `dart:html` for, behind an
/// interface that compiles on every platform.
///
/// ---------------------------------------------------------------------------
/// WHY THIS EXISTS
/// ---------------------------------------------------------------------------
/// Six files imported `dart:html` directly. That library does not exist outside
/// the web, so the Android build failed at compile time — which meant the
/// handheld app the whole SSR is built around (Section 17: four rugged Android
/// scanning guns; Section 11: offline working on those guns) could not be built
/// at all. `flutter analyze` had been reporting it as an info-level hint,
/// "avoid_web_libraries_in_flutter", for as long as the files have existed.
///
/// The fix is a conditional export, so each platform gets an implementation
/// that makes sense for it rather than a shim that pretends.
///
/// ---------------------------------------------------------------------------
/// WHY THE NATIVE SIDE IS NOT A PORT OF THE WEB SIDE
/// ---------------------------------------------------------------------------
/// The web behaviours are office behaviours, and the SSR says so:
///
///   * Printing. SSR §5.2: "The label goes to the printer of that work point
///     automatically. The operator never picks a printer." A browser print
///     dialog on a gun is the opposite of that. Native therefore writes the
///     document and says where it went, and real label printing belongs on the
///     server, addressed to the work point's printer.
///
///   * Picking a file. The SAP invoice upload (§10.1 method B) is a dispatch
///     office action on a desktop. A gun has no business with it, so native
///     refuses in plain words instead of silently doing nothing.
///
///   * The camera. §17 specifies a pistol grip with a hardware trigger; the
///     browser camera dialog is the desktop and tablet fallback. Native says to
///     use the trigger, or to key in the number printed under the code (§5).
library;

export 'platform_bridge_io.dart' if (dart.library.html) 'platform_bridge_web.dart';

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'platform_result.dart';

export 'platform_result.dart';

/// The handheld scans with its pistol-grip trigger (SSR §17), not a camera
/// preview. Screens read this to offer the trigger and a keyed-in fallback
/// instead of a camera dialog that would be slower and worse in plant lighting.
const bool kSupportsBrowserCamera = false;

/// The SAP invoice upload is a dispatch-office action on a desktop (§10.1).
const bool kSupportsFilePicker = false;

/// §5.2: on the floor "the label goes to the printer of that work point
/// automatically. The operator never picks a printer." A print dialog on a gun
/// is the wrong model, so native does not claim to offer one.
const bool kSupportsBrowserPrint = false;

/// Write the file where the operator can get at it, and say where it went.
///
/// Returns the path rather than null, which is the difference from web: the
/// browser owns its download folder and has already told the user, whereas here
/// nothing has been shown and the caller has to.
Future<String?> deliverBytes({
  required List<int> bytes,
  required String filename,
  required String mimeType,
}) async {
  final dir = await _outputDirectory();
  final file = File(p.join(dir.path, _safeName(filename)));
  await file.writeAsBytes(bytes, flush: true);
  return file.path;
}

/// Save the generated document and report the path.
///
/// Deliberately not a print dialog. Label printing from a gun belongs on the
/// server, addressed to the printer of that work point — putting a chooser in
/// front of the operator is the behaviour §5.2 exists to remove.
Future<String?> openHtmlDocument(String htmlContent, {String? title}) async {
  final dir = await _outputDirectory();
  final name = _safeName('${title ?? 'document'}.html');
  final file = File(p.join(dir.path, name));
  await file.writeAsString(htmlContent, flush: true);
  return file.path;
}

Future<PickedFile?> pickFile({String accept = '.xlsx,.xls,.csv'}) async {
  throw const PlatformUnsupported(
    'File upload is a dispatch office action. Please do this on the web portal.',
  );
}

String decodeAsText(List<int> bytes) => utf8.decode(bytes, allowMalformed: true);

/// Documents directory, falling back to the temporary one. A gun that cannot
/// reach either is in worse trouble than a failed export, but the export should
/// not be what crashes.
Future<Directory> _outputDirectory() async {
  try {
    return await getApplicationDocumentsDirectory();
  } catch (_) {
    return Directory.systemTemp;
  }
}

String _safeName(String name) => name.replaceAll(RegExp(r'[^\w\s.-]'), '').replaceAll(' ', '_');

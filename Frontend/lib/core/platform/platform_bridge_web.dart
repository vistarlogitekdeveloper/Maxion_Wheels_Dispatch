// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
//
// This file is only ever compiled for web — platform_bridge.dart selects it
// with a conditional export keyed on dart.library.html — so the two lints that
// exist to stop web libraries leaking into a mobile build are exactly the wrong
// advice here.

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'platform_result.dart';

export 'platform_result.dart';

/// Web: the browser downloads it.
const bool kSupportsBrowserCamera = true;
const bool kSupportsFilePicker = true;
const bool kSupportsBrowserPrint = true;

/// Hand the browser a file to save. Returns null because the browser owns the
/// destination — there is no path to report back.
Future<String?> deliverBytes({
  required List<int> bytes,
  required String filename,
  required String mimeType,
}) async {
  final blob = html.Blob([bytes], mimeType);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', filename)
    ..style.display = 'none';

  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(url);
  return null;
}

/// Open a generated HTML document in a new tab, where the operator prints it.
/// This is the office path; label printing on the floor is server-side (§5.2).
Future<String?> openHtmlDocument(String htmlContent, {String? title}) async {
  final blob = html.Blob([htmlContent], 'text/html;charset=utf-8');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.window.open(url, '_blank');
  return null;
}

/// Ask the browser for a file. Resolves to null if the operator cancels.
Future<PickedFile?> pickFile({String accept = '.xlsx,.xls,.csv'}) {
  final completer = Completer<PickedFile?>();

  final input = html.FileUploadInputElement()
    ..accept = accept
    ..style.display = 'none';

  html.document.body?.children.add(input);

  input.onChange.listen((_) {
    final files = input.files;
    if (files == null || files.isEmpty) {
      input.remove();
      if (!completer.isCompleted) completer.complete(null);
      return;
    }

    final file = files.first;
    final reader = html.FileReader();

    reader.onLoadEnd.listen((_) {
      input.remove();
      if (completer.isCompleted) return;
      final result = reader.result;
      completer.complete(
        PickedFile(
          name: file.name,
          bytes: result is List<int> ? result : const <int>[],
          text: result is String ? result : null,
        ),
      );
    });

    reader.onError.listen((_) {
      input.remove();
      if (!completer.isCompleted) completer.complete(null);
    });

    // Excel is binary; a CSV read as bytes is decoded by the caller.
    reader.readAsArrayBuffer(file);
  });

  // The operator closing the OS dialog fires no event at all, so the element
  // would leak and the future would never settle. Give up after five minutes.
  Timer(const Duration(minutes: 5), () {
    if (!completer.isCompleted) {
      input.remove();
      completer.complete(null);
    }
  });

  input.click();
  return completer.future;
}

/// Decode picked bytes as text, for the CSV and pasted-dump paths.
String decodeAsText(List<int> bytes) => utf8.decode(bytes, allowMalformed: true);

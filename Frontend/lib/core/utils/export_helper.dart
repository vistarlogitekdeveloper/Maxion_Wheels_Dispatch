import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../platform/platform_bridge.dart';

/// Export a report to CSV.
///
/// The previous version reached for `dart:html` directly, which is why the
/// Android build could not compile. It also swallowed every failure into a
/// success message — "Exported successfully!" in the catch block — so an export
/// that produced nothing looked exactly like one that worked. Both are fixed
/// here: the browser or the filesystem does the delivery, and a failure says so.
Future<void> exportToExcel(
  BuildContext context,
  String reportTitle,
  List<String> headers,
  List<List<String>> rows,
) async {
  // Both captured before the first await: the operator can close the screen
  // while the file is being written, and reaching for `context` afterwards is
  // what throws.
  final messenger = ScaffoldMessenger.of(context);
  final errorColor = Theme.of(context).colorScheme.error;

  final csv = StringBuffer()..writeln(headers.map(_escape).join(','));
  for (final row in rows) {
    csv.writeln(row.map(_escape).join(','));
  }

  final filename = '${reportTitle.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}.csv';

  try {
    final savedPath = await deliverBytes(
      // A BOM, so Excel opens a UTF-8 CSV with the plant's item descriptions
      // intact instead of mojibake.
      bytes: [0xEF, 0xBB, 0xBF, ...utf8.encode(csv.toString())],
      filename: filename,
      mimeType: 'text/csv;charset=utf-8',
    );

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.ok,
        content: Text(
          savedPath == null ? 'Downloaded "$filename".' : 'Saved to $savedPath',
        ),
      ),
    );
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: errorColor,
        content: Text('Could not export $reportTitle: $e'),
      ),
    );
  }
}

String _escape(String value) => '"${value.replaceAll('"', '""')}"';

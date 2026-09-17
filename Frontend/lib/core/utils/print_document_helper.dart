import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../platform/platform_bridge.dart';
import 'label_stock.dart';
import 'qr_svg.dart';

Future<void> openPrintableDocument({
  required BuildContext context,
  required String documentTitle,
  required String codeText,
  required String qrData,
  required String itemCode,
  String? itemDescription,
  required List<Map<String, String>> metadata,
  required List<String> tableHeaders,
  required List<List<String>> tableRows,
}) async {
  try {
    final metaHtml = metadata.map((m) {
      final k = m.keys.first;
      final v = m.values.first;
      return '<div class="meta-item"><span class="meta-label">$k:</span> <span class="meta-val">$v</span></div>';
    }).join('\n');

    final headersHtml = tableHeaders.map((h) => '<th>${h.toUpperCase()}</th>').join('');
    final rowsHtml = tableRows.map((row) {
      final cells = row.map((cell) => '<td>$cell</td>').join('');
      return '<tr>$cells</tr>';
    }).join('\n');

    // Encoded locally: an A4 gate pass must still print when the plant network
    // is down, and pallet/vehicle numbers should not leave the site.
    final qrMarkup = QrSvg.build(qrData, ecc: QrEcc.quartile);

    final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>$documentTitle - $codeText</title>
  <style>
    @page { size: A4 portrait; margin: 15mm; }
    body { font-family: 'Segoe UI', Arial, sans-serif; color: #111; background: #fff; margin: 0; padding: 20px; }
    .header { display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #E0218A; padding-bottom: 12px; margin-bottom: 20px; }
    .logo-title h1 { margin: 0; font-size: 22px; color: #111; text-transform: uppercase; letter-spacing: 1px; }
    .logo-title h3 { margin: 4px 0 0 0; font-size: 14px; color: #E0218A; }
    .qr-box { text-align: center; }
    .qr-box svg { width: 100px; height: 100px; display: block; }
    .qr-box p { margin: 4px 0 0 0; font-family: monospace; font-size: 11px; font-weight: bold; }
    .meta-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; background: #f8f9fa; padding: 14px; border: 1px solid #ddd; border-radius: 6px; margin-bottom: 20px; }
    .meta-label { font-size: 11px; font-weight: bold; color: #555; text-transform: uppercase; }
    .meta-val { font-size: 13px; font-weight: bold; color: #111; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; margin-bottom: 30px; }
    th { background: #1f2937; color: #fff; text-align: left; padding: 10px; font-size: 12px; border: 1px solid #1f2937; text-transform: uppercase; }
    td { padding: 10px; font-size: 12px; border: 1px solid #ddd; }
    tr:nth-child(even) { background: #f9fafb; }
    .footer { display: flex; justify-content: space-between; margin-top: 50px; padding-top: 20px; border-top: 1px solid #ddd; }
    .sig-box { text-align: center; width: 200px; }
    .sig-line { border-top: 1px dashed #333; margin-top: 40px; padding-top: 6px; font-size: 12px; font-weight: bold; }
  </style>
</head>
<body>
  <div class="header">
    <div class="logo-title">
      <h1>MAXION WHEELS DISPATCH OPERATIONS</h1>
      <h3>$documentTitle • $codeText</h3>
      <p style="margin:4px 0 0 0; font-size:12px; color:#666;">Item Code: <strong>$itemCode</strong> ${itemDescription != null ? "($itemDescription)" : ""}</p>
    </div>
    <div class="qr-box">
      $qrMarkup
      <p>$codeText</p>
    </div>
  </div>

  <div class="meta-grid">
    $metaHtml
  </div>

  <h4 style="margin: 0 0 8px 0; text-transform: uppercase; color: #333;">DOCUMENT DATA RECORDS (EXCEL FORMAT SHEET)</h4>
  <table>
    <thead>
      <tr>$headersHtml</tr>
    </thead>
    <tbody>
      $rowsHtml
    </tbody>
  </table>

  <div class="footer">
    <div class="sig-box">
      <div class="sig-line">OPERATOR / PREPARED BY</div>
    </div>
    <div class="sig-box">
      <div class="sig-line">QUALITY INSPECTOR</div>
    </div>
    <div class="sig-box">
      <div class="sig-line">DISPATCH HEAD APPROVAL</div>
    </div>
  </div>

  <script>
    window.onload = function() {
      setTimeout(function() {
        window.print();
      }, 500);
    };
  </script>
</body>
</html>
''';

    final messenger = ScaffoldMessenger.of(context);
    final savedPath = await openHtmlDocument(htmlContent, title: documentTitle);

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.ok,
        content: Text(
          savedPath == null
              // Web: a new tab opened and its own script calls print().
              ? 'Print window opened for $codeText.'
              // Handheld: SSR §5.2 sends labels to the printer of that work
              // point automatically — a chooser is the thing it removes. Saying
              // where the document went is the honest answer until server-side
              // printing addresses the work point's printer directly.
              : 'Saved to $savedPath',
        ),
      ),
    );
  } catch (e) {
    // The old version reported success here regardless, so a failed print
    // looked exactly like a successful one.
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text('Could not produce the document: $e'),
      ),
    );
  }
}

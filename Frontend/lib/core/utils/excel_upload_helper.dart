import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/datasources/remote_api.dart';
import '../constants/app_colors.dart';
import '../platform/platform_bridge.dart';

/// Pick a SAP invoice export and hand it to the server's parser
/// (SSR §10.1 method B — "the invoice is exported from SAP as a PDF or Excel
/// file and uploaded. The system reads the item codes and quantities from it").
///
/// This is a dispatch-office action on a desktop, so on a handheld the bridge
/// refuses in plain words rather than opening nothing.
Future<void> pickAndParseSapExcelFile({
  required BuildContext context,
  required RemoteApi remoteApi,
  required void Function(
    List<Map<String, dynamic>> items,
    String? invoiceNumber,
    String? customerName,
    String? vehicleNumber,
  ) onParsed,
}) async {
  final messenger = ScaffoldMessenger.of(context);

  try {
    final picked = await pickFile(
      accept: '.xlsx,.xls,.csv,text/csv,'
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,'
          'application/vnd.ms-excel',
    );

    // The operator closed the dialog. Not an error, and not worth a message.
    if (picked == null) return;

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.ribbonPink,
        duration: const Duration(seconds: 1),
        content: Text('Reading "${picked.name}"...'),
      ),
    );

    final response = await remoteApi.parseExcelDump(base64Encode(picked.bytes), picked.name);

    if (response['success'] == true && response['items'] != null) {
      final parsed = (response['items'] as List)
          .map((i) => Map<String, dynamic>.from(i as Map))
          .toList();

      onParsed(
        parsed,
        response['invoiceNumber'] as String?,
        response['customerName'] as String?,
        response['vehicleNumber'] as String?,
      );

      messenger.showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ok,
          content: Text('Loaded ${parsed.length} line(s) from "${picked.name}".'),
        ),
      );
      return;
    }

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.warn,
        content: Text(
          (response['message'] as String?) ??
              'Could not read that file. Check it is the SAP invoice export, then try again.',
        ),
      ),
    );
  } on PlatformUnsupported catch (e) {
    messenger.showSnackBar(
      SnackBar(backgroundColor: AppColors.warn, content: Text(e.message)),
    );
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.danger,
        content: Text('Could not read that file: $e'),
      ),
    );
  }
}

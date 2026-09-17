import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';

/// Handheld scanning: the gun's hardware trigger, with keyed entry as the
/// fallback.
///
/// A rugged scanning gun presents its laser as a keyboard — pulling the trigger
/// types the decoded payload and presses Enter. So the correct native UI is a
/// focused field that is already listening, not a camera preview. That also
/// satisfies the numbers SSR sets: T-01 gives a scan under one second, and §12.1
/// wants any working screen within two taps.
///
/// Keying in is the documented fallback, not a workaround — §5 prints the same
/// information in plain text under every QR "so a damaged code can still be
/// keyed in".
class CameraQrScannerDialog extends StatefulWidget {
  const CameraQrScannerDialog({
    super.key,
    required this.activeItemCode,
    required this.onQrScanned,
  });

  final String activeItemCode;
  final Function(String scannedQr) onQrScanned;

  static Future<String?> show({
    required BuildContext context,
    required String activeItemCode,
    required Function(String scannedQr) onQrScanned,
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => CameraQrScannerDialog(
        activeItemCode: activeItemCode,
        onQrScanned: onQrScanned,
      ),
    );
  }

  @override
  State<CameraQrScannerDialog> createState() => _CameraQrScannerDialogState();
}

class _CameraQrScannerDialogState extends State<CameraQrScannerDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _error;

  @override
  void initState() {
    super.initState();
    // The trigger types into whatever has focus, so the field must have it
    // before the operator can pull. Requested after the first frame because the
    // dialog is not attached yet during initState.
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit(String raw) {
    final value = raw.trim();
    if (value.isEmpty) {
      setState(() => _error = 'Pull the trigger to scan, or type the number printed under the code.');
      return;
    }

    widget.onQrScanned(value);
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('SCAN'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Item ${widget.activeItemCode}',
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Pull the trigger. The code appears here on its own.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            textInputAction: TextInputAction.done,
            // The gun ends every scan with Enter, so this is what fires on a
            // successful pull as well as on a keyed-in code.
            onSubmitted: _submit,
            inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
            decoration: InputDecoration(
              labelText: 'Scanned code',
              hintText: 'Waiting for the trigger…',
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
            // SSR T-07 wants text readable at arm's length in plant lighting.
            style: const TextStyle(fontSize: 20, fontFamily: 'monospace'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.ok,
            // 12 mm minimum, for gloved hands (SSR T-07).
            minimumSize: const Size(96, 48),
          ),
          onPressed: () => _submit(_controller.text),
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }
}

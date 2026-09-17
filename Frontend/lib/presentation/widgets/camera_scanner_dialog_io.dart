import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';

/// Handheld picking scan: the gun's hardware trigger, with the expected values
/// listed so the picker can confirm at a glance.
///
/// SSR Module 7 wants the picker shown "one instruction at a time: go to this
/// location, take this pallet", so the pending list here is a short confirmation
/// aid rather than a menu to choose from — tapping one is the fallback when a
/// label is damaged, exactly as §5 intends.
class CameraScannerDialog extends StatefulWidget {
  const CameraScannerDialog({
    super.key,
    required this.scanType,
    required this.pendingItems,
    required this.onScanComplete,
  });

  /// 'LOCATION' or 'PALLET'.
  final String scanType;
  final List<dynamic> pendingItems;
  final ValueChanged<String> onScanComplete;

  @override
  State<CameraScannerDialog> createState() => _CameraScannerDialogState();
}

class _CameraScannerDialogState extends State<CameraScannerDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _error;

  bool get _isLocation => widget.scanType == 'LOCATION';

  @override
  void initState() {
    super.initState();
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
      setState(() => _error = 'Pull the trigger to scan, or tap the expected value below.');
      return;
    }
    widget.onScanComplete(value);
    Navigator.of(context).pop();
  }

  String _expectedValue(dynamic item) {
    final map = item as Map;
    return (_isLocation ? map['locationCode'] : map['palletNumber'])?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expected = widget.pendingItems.map(_expectedValue).where((v) => v.isNotEmpty).toList();

    return AlertDialog(
      title: Text(_isLocation ? 'SCAN LOCATION' : 'SCAN PALLET'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pull the trigger. The code appears here on its own.',
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: _submit,
              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
              decoration: InputDecoration(
                labelText: _isLocation ? 'Location code' : 'Pallet number',
                hintText: 'Waiting for the trigger…',
                errorText: _error,
                border: const OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 20, fontFamily: 'monospace'),
            ),
            if (expected.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('EXPECTED', style: theme.textTheme.labelSmall),
              const SizedBox(height: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final value in expected)
                        ActionChip(
                          label: Text(value, style: const TextStyle(fontFamily: 'monospace')),
                          onPressed: () => _submit(value),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.ok,
            minimumSize: const Size(96, 48),
          ),
          onPressed: () => _submit(_controller.text),
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }
}

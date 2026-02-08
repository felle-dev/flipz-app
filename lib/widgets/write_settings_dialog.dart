import 'package:flutter/material.dart';
import '../../config/app_strings.dart';

class WriteSettingsDialog extends StatelessWidget {
  final VoidCallback onOpenSettings;

  const WriteSettingsDialog({super.key, required this.onOpenSettings});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.settings),
          SizedBox(width: 8),
          Text(AppStrings.quickTilesEnableSystemSettings),
        ],
      ),
      content: Text(AppStrings.quickTilesWriteSettingsRequired),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.quickTilesCancel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            onOpenSettings();
          },
          child: Text(AppStrings.quickTilesOpenSettings),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/quick_tiles_constants.dart';

class AccessibilityDialog extends StatelessWidget {
  final String tileId;
  final VoidCallback onOpenSettings;

  const AccessibilityDialog({
    super.key,
    required this.tileId,
    required this.onOpenSettings,
  });

  String get featureName {
    return tileId == QuickTilesConstants.tileIdScreenshot
        ? AppStrings.quickTilesScreenshot
        : AppStrings.quickTilesLockScreen;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.accessibility_new),
          SizedBox(width: 8),
          Text(AppStrings.quickTilesEnableAccessibility),
        ],
      ),
      content: Text(
        '$featureName ${AppStrings.quickTilesAccessibilityRequired}',
      ),
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

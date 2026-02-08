import 'package:flutter/material.dart';
import '../../../config/app_strings.dart';

class QuickTilesInfoDialog extends StatelessWidget {
  const QuickTilesInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.info_outline),
          SizedBox(width: 8),
          Text(AppStrings.quickTilesAboutTitle),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.quickTilesAboutDescription,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              AppStrings.quickTilesHowToUse,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(AppStrings.quickTilesStep1),
            Text(AppStrings.quickTilesStep2),
            Text(AppStrings.quickTilesStep3),
            Text(AppStrings.quickTilesStep4),
            SizedBox(height: 16),
            Text(
              AppStrings.quickTilesPermissionsRequired,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(AppStrings.quickTilesPermissionLockScreen),
            Text(AppStrings.quickTilesPermissionScreenshot),
            Text(AppStrings.quickTilesPermissionScreenTimeout),
            SizedBox(height: 16),
            Text(
              AppStrings.quickTilesScreenTimeoutInfo,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(AppStrings.quickTilesScreenTimeoutToggle),
            Text(AppStrings.quickTilesScreenTimeout1Min),
            Text(AppStrings.quickTilesScreenTimeout30Min),
            SizedBox(height: 16),
            Text(
              AppStrings.quickTilesTroubleshooting,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              AppStrings.quickTilesTroubleshootingIntro,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              AppStrings.quickTilesTroubleshootingStep1,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              AppStrings.quickTilesTroubleshootingStep2,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              AppStrings.quickTilesTroubleshootingStep3,
              style: TextStyle(fontSize: 12),
            ),
            Text(
              AppStrings.quickTilesTroubleshootingStep4,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 16),
            Text(
              AppStrings.quickTilesNote,
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.quickTilesGotIt),
        ),
      ],
    );
  }
}

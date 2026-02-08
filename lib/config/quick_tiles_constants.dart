import 'package:flutter/material.dart';

/// Configuration constants for Quick Tiles feature
class QuickTilesConstants {
  // Platform channel
  static const String platformChannel = 'com.random.app/quick_tiles';

  // Platform methods
  static const String methodGetActiveTiles = 'getActiveTiles';
  static const String methodAddTile = 'addTile';
  static const String methodRemoveTile = 'removeTile';
  static const String methodCheckAccessibility = 'checkAccessibility';
  static const String methodCheckWriteSettings = 'checkWriteSettings';
  static const String methodOpenAccessibilitySettings =
      'openAccessibilitySettings';
  static const String methodOpenWriteSettingsPermission =
      'openWriteSettingsPermission';

  // Method parameters
  static const String paramTileId = 'tileId';

  // Tile IDs
  static const String tileIdLockScreen = 'lock_screen';
  static const String tileIdVolumeControl = 'volume_control';
  static const String tileIdScreenshot = 'screenshot';
  static const String tileIdScreenTimeout = 'screen_timeout';

  // Tile icons
  static const IconData iconLockScreen = Icons.lock_outlined;
  static const IconData iconVolumeControl = Icons.volume_up_outlined;
  static const IconData iconScreenshot = Icons.screenshot_outlined;
  static const IconData iconScreenTimeout = Icons.timer_outlined;

  // Tile colors
  static const Color colorLockScreen = Colors.red;
  static const Color colorVolumeControl = Colors.deepPurple;
  static const Color colorScreenshot = Colors.blue;
  static const Color colorScreenTimeout = Colors.orange;

  // UI constants
  static const double tileIconPadding = 8.0;
  static const double tileIconBorderRadius = 8.0;
  static const double tileColorOpacity = 0.2;
  static const double tileDividerIndent = 72.0;
}

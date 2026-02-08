import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../../config/app_strings.dart';
import '../../../config/quick_tiles_constants.dart';
import '../../../models/quick_tile.dart';

class QuickTilesController extends ChangeNotifier {
  static const platform = MethodChannel(QuickTilesConstants.platformChannel);

  final List<QuickTile> _availableTiles = [
    QuickTile(
      id: QuickTilesConstants.tileIdLockScreen,
      title: AppStrings.quickTilesLockScreen,
      subtitle: AppStrings.quickTilesLockScreenSubtitle,
      icon: QuickTilesConstants.iconLockScreen,
      color: QuickTilesConstants.colorLockScreen,
    ),
    QuickTile(
      id: QuickTilesConstants.tileIdVolumeControl,
      title: AppStrings.quickTilesVolumeControl,
      subtitle: AppStrings.quickTilesVolumeControlSubtitle,
      icon: QuickTilesConstants.iconVolumeControl,
      color: QuickTilesConstants.colorVolumeControl,
    ),
    QuickTile(
      id: QuickTilesConstants.tileIdScreenshot,
      title: AppStrings.quickTilesScreenshot,
      subtitle: AppStrings.quickTilesScreenshotSubtitle,
      icon: QuickTilesConstants.iconScreenshot,
      color: QuickTilesConstants.colorScreenshot,
    ),
    QuickTile(
      id: QuickTilesConstants.tileIdScreenTimeout,
      title: AppStrings.quickTilesScreenTimeout,
      subtitle: AppStrings.quickTilesScreenTimeoutSubtitle,
      icon: QuickTilesConstants.iconScreenTimeout,
      color: QuickTilesConstants.colorScreenTimeout,
    ),
  ];

  Set<String> _activeTiles = {};
  bool _isLoading = true;

  // Getters
  List<QuickTile> get availableTiles => _availableTiles;
  Set<String> get activeTiles => _activeTiles;
  bool get isLoading => _isLoading;
  int get activeTilesCount => _activeTiles.length;
  int get totalTilesCount => _availableTiles.length;

  Future<void> initialize() async {
    await loadActiveTiles();
  }

  Future<void> loadActiveTiles() async {
    try {
      final result = await platform.invokeMethod(
        QuickTilesConstants.methodGetActiveTiles,
      );
      _activeTiles = Set<String>.from(result ?? []);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Failed to load active tiles: $e');
    }
  }

  bool isTileActive(String tileId) {
    return _activeTiles.contains(tileId);
  }

  Future<ToggleTileResult> toggleTile(String tileId, bool isActive) async {
    try {
      // Check accessibility for screenshot and lock screen tiles
      if ((tileId == QuickTilesConstants.tileIdScreenshot ||
              tileId == QuickTilesConstants.tileIdLockScreen) &&
          isActive) {
        final bool accessibilityEnabled = await checkAccessibility();

        if (!accessibilityEnabled) {
          return ToggleTileResult(
            success: false,
            requiresAccessibility: true,
            tileId: tileId,
          );
        }
      }

      // Check WRITE_SETTINGS permission for screen timeout
      if (tileId == QuickTilesConstants.tileIdScreenTimeout && isActive) {
        final bool writeSettingsEnabled = await checkWriteSettings();

        if (!writeSettingsEnabled) {
          return ToggleTileResult(
            success: false,
            requiresWriteSettings: true,
            tileId: tileId,
          );
        }
      }

      if (isActive) {
        await platform.invokeMethod(QuickTilesConstants.methodAddTile, {
          QuickTilesConstants.paramTileId: tileId,
        });
        _activeTiles.add(tileId);
        notifyListeners();
        return ToggleTileResult(
          success: true,
          isAdded: true,
          message: _getSuccessMessage(tileId),
        );
      } else {
        await platform.invokeMethod(QuickTilesConstants.methodRemoveTile, {
          QuickTilesConstants.paramTileId: tileId,
        });
        _activeTiles.remove(tileId);
        notifyListeners();
        return ToggleTileResult(
          success: true,
          isAdded: false,
          message: AppStrings.quickTilesTileRemoved,
        );
      }
    } catch (e) {
      debugPrint('Failed to toggle tile: $e');
      return ToggleTileResult(
        success: false,
        error: '${AppStrings.quickTilesUpdateFailed}$e',
      );
    }
  }

  String _getSuccessMessage(String tileId) {
    switch (tileId) {
      case QuickTilesConstants.tileIdScreenshot:
        return AppStrings.quickTilesScreenshotAdded;
      case QuickTilesConstants.tileIdLockScreen:
        return AppStrings.quickTilesLockScreenAdded;
      case QuickTilesConstants.tileIdScreenTimeout:
        return AppStrings.quickTilesScreenTimeoutAdded;
      default:
        return AppStrings.quickTilesTileAdded;
    }
  }

  Future<bool> checkAccessibility() async {
    try {
      final result = await platform.invokeMethod(
        QuickTilesConstants.methodCheckAccessibility,
      );
      return result as bool? ?? false;
    } catch (e) {
      debugPrint('Failed to check accessibility: $e');
      return false;
    }
  }

  Future<bool> checkWriteSettings() async {
    try {
      final result = await platform.invokeMethod(
        QuickTilesConstants.methodCheckWriteSettings,
      );
      return result as bool? ?? false;
    } catch (e) {
      debugPrint('Failed to check write settings: $e');
      return false;
    }
  }

  Future<void> openAccessibilitySettings() async {
    try {
      await platform.invokeMethod(
        QuickTilesConstants.methodOpenAccessibilitySettings,
      );
    } catch (e) {
      debugPrint('Failed to open accessibility settings: $e');
    }
  }

  Future<void> openWriteSettingsPermission() async {
    try {
      await platform.invokeMethod(
        QuickTilesConstants.methodOpenWriteSettingsPermission,
      );
    } catch (e) {
      debugPrint('Failed to open write settings permission: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Result of a tile toggle operation
class ToggleTileResult {
  final bool success;
  final bool isAdded;
  final String? message;
  final String? error;
  final bool requiresAccessibility;
  final bool requiresWriteSettings;
  final String? tileId;

  ToggleTileResult({
    required this.success,
    this.isAdded = false,
    this.message,
    this.error,
    this.requiresAccessibility = false,
    this.requiresWriteSettings = false,
    this.tileId,
  });
}

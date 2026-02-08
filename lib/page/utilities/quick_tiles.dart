import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/quick_tiles_constants.dart';
import '../../controllers/quick_tiles_controller.dart';
import '../../widgets/quick_tile_item_widget.dart';
import '../../widgets/accessibility_dialog.dart';
import '../../widgets/write_settings_dialog.dart';
import '../../widgets/quick_tiles_info_dialog.dart';

class QuickTilesPage extends StatefulWidget {
  const QuickTilesPage({super.key});

  @override
  State<QuickTilesPage> createState() => _QuickTilesPageState();
}

class _QuickTilesPageState extends State<QuickTilesPage> {
  late QuickTilesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuickTilesController();
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showTileInfo() {
    showDialog(
      context: context,
      builder: (context) => const QuickTilesInfoDialog(),
    );
  }

  void _showAccessibilityDialog(String tileId) {
    showDialog(
      context: context,
      builder: (context) => AccessibilityDialog(
        tileId: tileId,
        onOpenSettings: _controller.openAccessibilitySettings,
      ),
    );
  }

  void _showWriteSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => WriteSettingsDialog(
        onOpenSettings: _controller.openWriteSettingsPermission,
      ),
    );
  }

  Future<void> _handleTileToggle(String tileId, bool value) async {
    final result = await _controller.toggleTile(tileId, value);

    if (!mounted) return;

    if (result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message ?? ''),
          action: SnackBarAction(
            label: AppStrings.quickTilesOk,
            onPressed: () {},
          ),
        ),
      );
    } else if (result.requiresAccessibility) {
      _showAccessibilityDialog(result.tileId!);
    } else if (result.requiresWriteSettings) {
      _showWriteSettingsDialog();
    } else if (result.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.error!), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.quickTilesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showTileInfo,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Active Tiles Count
              Text(
                '${AppStrings.quickTilesActiveTiles}: ${_controller.activeTilesCount}/${_controller.totalTilesCount}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Available Tiles List
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: theme.colorScheme.surface,
                ),
                child: Column(
                  children: [
                    for (
                      int i = 0;
                      i < _controller.availableTiles.length;
                      i++
                    ) ...[
                      QuickTileItemWidget(
                        tile: _controller.availableTiles[i],
                        isActive: _controller.isTileActive(
                          _controller.availableTiles[i].id,
                        ),
                        onToggle: (value) {
                          _handleTileToggle(
                            _controller.availableTiles[i].id,
                            value,
                          );
                        },
                      ),
                      if (i < _controller.availableTiles.length - 1)
                        Divider(
                          height: 1,
                          indent: QuickTilesConstants.tileDividerIndent,
                          color: theme.colorScheme.outlineVariant,
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }
}

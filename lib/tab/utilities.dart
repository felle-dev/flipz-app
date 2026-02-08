import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flipz/page/utilities/exif_eraser.dart';
import 'package:flipz/page/utilities/device_info.dart';
import 'package:flipz/page/utilities/quick_tiles.dart';
import 'package:flipz/page/utilities/unit_converter.dart';
import 'package:flipz/page/utilities/tg_monet.dart';
import 'package:flipz/models/utility_item.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';
import 'package:flipz/utils/preferences_helper.dart';
import 'package:flipz/utils/language_provider.dart';
import 'package:flipz/widgets/utility_list_card.dart';

class UtilitiesTab extends StatefulWidget {
  const UtilitiesTab({super.key});

  @override
  State<UtilitiesTab> createState() => _UtilitiesTabState();
}

class _UtilitiesTabState extends State<UtilitiesTab> {
  late List<UtilityItem> _utilities;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _utilities = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Always rebuild the list to get updated translations
    _buildUtilitiesList();

    // Only load pinned state from storage once
    if (!_isInitialized) {
      _loadPinnedState();
      _isInitialized = true;
    }
  }

  void _buildUtilitiesList() {
    final colorScheme = Theme.of(context).colorScheme;

    // Store current pinned state before rebuilding
    final Map<String, bool> pinnedState = {};
    for (var utility in _utilities) {
      pinnedState[utility.id] = utility.isPinned;
    }

    _utilities = [
      UtilityItem(
        id: 'exif_eraser',
        title: AppStrings.utilityExifEraser,
        subtitle: AppStrings.utilityExifEraserSubtitle,
        icon: Icons.photo_camera_back_outlined,
        containerColor: colorScheme.secondaryContainer,
        pageBuilder: () => const ExifEraserPage(),
      ),
      UtilityItem(
        id: 'quick_tiles',
        title: AppStrings.utilityQuickTiles,
        subtitle: AppStrings.utilityQuickTilesSubtitle,
        icon: Icons.dashboard_customize_outlined,
        containerColor: colorScheme.primaryContainer,
        pageBuilder: () => const QuickTilesPage(),
      ),
      UtilityItem(
        id: 'unit_converter',
        title: AppStrings.utilityUnitConverter,
        subtitle: AppStrings.utilityUnitConverterSubtitle,
        icon: Icons.compare_arrows_outlined,
        containerColor: colorScheme.tertiaryContainer,
        pageBuilder: () => const UnitConverterPage(),
      ),
      UtilityItem(
        id: 'device_info',
        title: AppStrings.utilityDeviceInfo,
        subtitle: AppStrings.utilityDeviceInfoSubtitle,
        icon: Icons.info_outline,
        containerColor: colorScheme.primaryContainer,
        pageBuilder: () => const DeviceInfoPage(),
      ),
      UtilityItem(
        id: 'tg_monet',
        title: "Telegram Monet",
        subtitle: "Telegram Monet Theme Generator",
        icon: Icons.format_paint_outlined,
        containerColor: colorScheme.tertiaryContainer,
        pageBuilder: () => const TelegramMonetPage(),
      ),
    ];

    // Restore pinned state after rebuilding list
    for (var utility in _utilities) {
      if (pinnedState.containsKey(utility.id)) {
        utility.isPinned = pinnedState[utility.id]!;
      }
    }
  }

  Future<void> _loadPinnedState() async {
    final pinnedIds = await PreferencesHelper.getPinnedUtilities();

    if (mounted) {
      setState(() {
        for (var utility in _utilities) {
          utility.isPinned = pinnedIds.contains(utility.id);
        }
      });
    }
  }

  Future<void> _savePinnedState() async {
    final pinnedIds = _utilities
        .where((u) => u.isPinned)
        .map((u) => u.id)
        .toList();
    await PreferencesHelper.savePinnedUtilities(pinnedIds);
  }

  List<UtilityItem> get _pinnedUtilities =>
      _utilities.where((u) => u.isPinned).toList();

  List<UtilityItem> get _unpinnedUtilities =>
      _utilities.where((u) => !u.isPinned).toList();

  void _togglePin(UtilityItem item) {
    setState(() {
      item.isPinned = !item.isPinned;
    });
    _savePinnedState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        // Rebuild list when language changes
        _buildUtilitiesList();

        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final pinnedItems = _pinnedUtilities;
        final unpinnedItems = _unpinnedUtilities;

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: CustomScrollView(
            slivers: [
              // Pinned section
              if (pinnedItems.isNotEmpty) ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimensions.paddingMedium,
                    AppDimensions.paddingMedium,
                    AppDimensions.paddingMedium,
                    AppDimensions.paddingSmall,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Icon(
                          Icons.push_pin,
                          size: AppDimensions.iconXSmall,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: AppDimensions.spacing8),
                        Text(
                          AppStrings.pinned,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = pinnedItems[index];
                      return UtilityListCard(
                        key: ValueKey(item.id),
                        item: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item.pageBuilder(),
                            ),
                          );
                        },
                        onTogglePin: () => _togglePin(item),
                      );
                    }, childCount: pinnedItems.length),
                  ),
                ),
              ],

              // Unpinned section
              if (unpinnedItems.isNotEmpty) ...[
                if (pinnedItems.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.paddingMedium,
                      AppDimensions.paddingLarge,
                      AppDimensions.paddingMedium,
                      AppDimensions.paddingSmall,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        AppStrings.allUtilities,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = unpinnedItems[index];
                      return UtilityListCard(
                        key: ValueKey(item.id),
                        item: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item.pageBuilder(),
                            ),
                          );
                        },
                        onTogglePin: () => _togglePin(item),
                      );
                    }, childCount: unpinnedItems.length),
                  ),
                ),
              ],

              const SliverToBoxAdapter(
                child: SizedBox(height: AppDimensions.spacing100),
              ),
            ],
          ),
        );
      },
    );
  }
}

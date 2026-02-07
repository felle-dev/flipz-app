import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flipz/page/games/random_number.dart';
import 'package:flipz/page/games/dice_roller.dart';
import 'package:flipz/page/games/coin_flip.dart';
import 'package:flipz/page/games/spinning_wheel.dart';
import 'package:flipz/models/game_item.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';
import 'package:flipz/utils/preferences_helper.dart';
import 'package:flipz/utils/language_provider.dart';
import 'package:flipz/widgets/game_list_card.dart';

class GamesToolsTab extends StatefulWidget {
  const GamesToolsTab({super.key});

  @override
  State<GamesToolsTab> createState() => _GamesToolsTabState();
}

class _GamesToolsTabState extends State<GamesToolsTab> {
  late List<GameItem> _tools;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _tools = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Always rebuild the list to get updated translations
    _buildToolsList();

    // Only load pinned state from storage once
    if (!_isInitialized) {
      _loadPinnedState();
      _isInitialized = true;
    }
  }

  void _buildToolsList() {
    final colorScheme = Theme.of(context).colorScheme;

    // Store current pinned state before rebuilding
    final Map<String, bool> pinnedState = {};
    for (var tool in _tools) {
      pinnedState[tool.id] = tool.isPinned;
    }

    _tools = [
      GameItem(
        id: 'random_number',
        title: AppStrings.gameRandomNumber,
        subtitle: AppStrings.gameRandomNumberSubtitle,
        icon: Icons.numbers,
        containerColor: colorScheme.primaryContainer,
        pageBuilder: () => const RandomNumberPage(),
      ),
      GameItem(
        id: 'dice_roller',
        title: AppStrings.gameDiceRoller,
        subtitle: AppStrings.gameDiceRollerSubtitle,
        icon: Icons.casino_outlined,
        containerColor: colorScheme.secondaryContainer,
        pageBuilder: () => const DiceRollerPage(),
      ),
      GameItem(
        id: 'coin_flip',
        title: AppStrings.gameCoinFlip,
        subtitle: AppStrings.gameCoinFlipSubtitle,
        icon: Icons.monetization_on_outlined,
        containerColor: colorScheme.tertiaryContainer,
        pageBuilder: () => const CoinFlipPage(),
      ),
      GameItem(
        id: 'spinning_wheel',
        title: AppStrings.gameSpinningWheel,
        subtitle: AppStrings.gameSpinningWheelSubtitle,
        icon: Icons.album_outlined,
        containerColor: colorScheme.primaryContainer,
        pageBuilder: () => const SpinningWheelPage(),
      ),
    ];

    // Restore pinned state after rebuilding list
    for (var tool in _tools) {
      if (pinnedState.containsKey(tool.id)) {
        tool.isPinned = pinnedState[tool.id]!;
      }
    }
  }

  Future<void> _loadPinnedState() async {
    final pinnedIds = await PreferencesHelper.getPinnedGames();

    if (mounted) {
      setState(() {
        for (var tool in _tools) {
          tool.isPinned = pinnedIds.contains(tool.id);
        }
      });
    }
  }

  Future<void> _savePinnedState() async {
    final pinnedIds = _tools.where((t) => t.isPinned).map((t) => t.id).toList();
    await PreferencesHelper.savePinnedGames(pinnedIds);
  }

  List<GameItem> get _pinnedTools => _tools.where((t) => t.isPinned).toList();

  List<GameItem> get _unpinnedTools =>
      _tools.where((t) => !t.isPinned).toList();

  void _togglePin(GameItem item) {
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
        _buildToolsList();

        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final pinnedItems = _pinnedTools;
        final unpinnedItems = _unpinnedTools;

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
                      return GameListCard(
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
                        AppStrings.allGames,
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
                      return GameListCard(
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

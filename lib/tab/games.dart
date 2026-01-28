import 'package:flutter/material.dart';
import 'package:random/page/games/random_number.dart';
import 'package:random/page/games/dice_roller.dart';
import 'package:random/page/games/coin_flip.dart';
import 'package:random/page/games/spinning_wheel.dart';
import 'package:random/models/game_item.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';
import 'package:random/utils/preferences_helper.dart';
import 'package:random/widgets/game_list_card.dart';

class GamesToolsTab extends StatefulWidget {
  const GamesToolsTab({super.key});

  @override
  State<GamesToolsTab> createState() => _GamesToolsTabState();
}

class _GamesToolsTabState extends State<GamesToolsTab> {
  late List<GameItem> _tools;

  @override
  void initState() {
    super.initState();
    _tools = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_tools.isEmpty) {
      final colorScheme = Theme.of(context).colorScheme;
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
          containerColor: colorScheme.errorContainer,
          pageBuilder: () => const SpinningWheelPage(),
        ),
      ];
      _loadPinnedState();
    }
  }

  Future<void> _loadPinnedState() async {
    final pinnedIds = await PreferencesHelper.getPinnedGames();

    setState(() {
      for (var tool in _tools) {
        tool.isPinned = pinnedIds.contains(tool.id);
      }
    });
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
  }
}

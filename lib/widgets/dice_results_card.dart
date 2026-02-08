import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/dice_roller_constants.dart';

class DiceResultsCard extends StatelessWidget {
  final List<int> results;
  final int total;
  final bool showTotal;

  const DiceResultsCard({
    super.key,
    required this.results,
    required this.total,
    required this.showTotal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: DiceRollerConstants.borderWidth,
        ),
        borderRadius: BorderRadius.circular(DiceRollerConstants.borderRadius),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              DiceRollerConstants.paddingCardHeader,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.stars_outlined,
                  color: theme.colorScheme.primary,
                  size: DiceRollerConstants.iconSizeSmall,
                ),
                const SizedBox(width: DiceRollerConstants.spacing8),
                Text(
                  AppStrings.diceRollerResults,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(
              DiceRollerConstants.paddingCardContent,
            ),
            child: Column(
              children: [
                Wrap(
                  spacing: DiceRollerConstants.diceSpacing,
                  runSpacing: DiceRollerConstants.diceSpacing,
                  alignment: WrapAlignment.center,
                  children: results.map((result) {
                    return Container(
                      width: DiceRollerConstants.diceSize,
                      height: DiceRollerConstants.diceSize,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          DiceRollerConstants.diceBorderRadius,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$result',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (showTotal) ...[
                  const SizedBox(height: DiceRollerConstants.spacing16),
                  Text(
                    '${AppStrings.diceRollerTotal}: $total',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

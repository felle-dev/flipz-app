import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/dice_roller_constants.dart';

class DiceSettingsCard extends StatelessWidget {
  final int numberOfDice;
  final int sides;
  final Function(int) onNumberOfDiceChanged;
  final Function(int) onSidesChanged;

  const DiceSettingsCard({
    super.key,
    required this.numberOfDice,
    required this.sides,
    required this.onNumberOfDiceChanged,
    required this.onSidesChanged,
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
                  Icons.tune_outlined,
                  color: theme.colorScheme.primary,
                  size: DiceRollerConstants.iconSizeSmall,
                ),
                const SizedBox(width: DiceRollerConstants.spacing8),
                Text(
                  AppStrings.diceRollerSettings,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.diceRollerNumberOfDice}: $numberOfDice',
                  style: theme.textTheme.titleMedium,
                ),
                Slider(
                  value: numberOfDice.toDouble(),
                  min: DiceRollerConstants.minNumberOfDice.toDouble(),
                  max: DiceRollerConstants.maxNumberOfDice.toDouble(),
                  divisions: DiceRollerConstants.sliderDivisions,
                  onChanged: (value) => onNumberOfDiceChanged(value.toInt()),
                ),
                const SizedBox(height: DiceRollerConstants.spacing16),
                Text(
                  '${AppStrings.diceRollerSides}: $sides',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: DiceRollerConstants.spacing12),
                Wrap(
                  spacing: DiceRollerConstants.spacing8,
                  children: DiceRollerConstants.availableSides.map((diceSides) {
                    return ChoiceChip(
                      label: Text('D$diceSides'),
                      selected: sides == diceSides,
                      onSelected: (selected) {
                        if (selected) onSidesChanged(diceSides);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

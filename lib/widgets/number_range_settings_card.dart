import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/random_number_constants.dart';

class NumberRangeSettingsCard extends StatelessWidget {
  final TextEditingController minController;
  final TextEditingController maxController;
  final Function(String) onMinChanged;
  final Function(String) onMaxChanged;

  const NumberRangeSettingsCard({
    super.key,
    required this.minController,
    required this.maxController,
    required this.onMinChanged,
    required this.onMaxChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: RandomNumberConstants.borderWidth,
        ),
        borderRadius: BorderRadius.circular(RandomNumberConstants.borderRadius),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              RandomNumberConstants.paddingCardHeader,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tune_outlined,
                  color: theme.colorScheme.primary,
                  size: RandomNumberConstants.iconSizeSmall,
                ),
                const SizedBox(width: RandomNumberConstants.spacing8),
                Text(
                  AppStrings.randomNumberRange,
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
              RandomNumberConstants.paddingCardContent,
            ),
            child: Column(
              children: [
                TextField(
                  controller: minController,
                  decoration: InputDecoration(
                    labelText: AppStrings.randomNumberMinimum,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.remove_circle_outline),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: onMinChanged,
                ),
                const SizedBox(height: RandomNumberConstants.spacing16),
                TextField(
                  controller: maxController,
                  decoration: InputDecoration(
                    labelText: AppStrings.randomNumberMaximum,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.add_circle_outline),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: onMaxChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

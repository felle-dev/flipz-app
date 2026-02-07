import 'package:flutter/material.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';

class GeneratorOptionsCard extends StatelessWidget {
  final bool includeAdjective;
  final bool includeNumbers;
  final bool capitalize;
  final String separator;
  final List<String> separators;
  final ValueChanged<bool> onAdjectiveChanged;
  final ValueChanged<bool> onNumbersChanged;
  final ValueChanged<bool> onCapitalizeChanged;
  final ValueChanged<String> onSeparatorChanged;

  const GeneratorOptionsCard({
    super.key,
    required this.includeAdjective,
    required this.includeNumbers,
    required this.capitalize,
    required this.separator,
    required this.separators,
    required this.onAdjectiveChanged,
    required this.onNumbersChanged,
    required this.onCapitalizeChanged,
    required this.onSeparatorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Icon(
                  Icons.tune_outlined,
                  color: theme.colorScheme.primary,
                  size: AppDimensions.iconMedium,
                ),
                const SizedBox(width: AppDimensions.spacing8),
                Text(
                  AppStrings.options,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          SwitchListTile(
            title: Text(AppStrings.includeAdjective),
            subtitle: Text(AppStrings.includeAdjectiveSubtitle),
            value: includeAdjective,
            onChanged: onAdjectiveChanged,
          ),
          Divider(
            height: 1,
            indent: AppDimensions.paddingMedium,
            endIndent: AppDimensions.paddingMedium,
            color: theme.colorScheme.outlineVariant,
          ),
          SwitchListTile(
            title: Text(AppStrings.includeNumbers),
            subtitle: Text(AppStrings.includeNumbersSubtitle),
            value: includeNumbers,
            onChanged: onNumbersChanged,
          ),
          Divider(
            height: 1,
            indent: AppDimensions.paddingMedium,
            endIndent: AppDimensions.paddingMedium,
            color: theme.colorScheme.outlineVariant,
          ),
          SwitchListTile(
            title: Text(AppStrings.capitalize),
            subtitle: Text(AppStrings.capitalizeSubtitle),
            value: capitalize,
            onChanged: onCapitalizeChanged,
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.separator, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppDimensions.spacing12),
                Wrap(
                  spacing: AppDimensions.spacing8,
                  children: separators.map((sep) {
                    return ChoiceChip(
                      label: Text(sep.isEmpty ? AppStrings.separatorNone : sep),
                      selected: separator == sep,
                      onSelected: (selected) {
                        if (selected) onSeparatorChanged(sep);
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

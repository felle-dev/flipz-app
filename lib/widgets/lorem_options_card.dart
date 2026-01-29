import 'package:flutter/material.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';
import 'package:random/config/lorem_constants.dart';

class LoremOptionsCard extends StatelessWidget {
  final String type;
  final int count;
  final bool startWithLorem;
  final int maxCount;
  final int divisions;
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<int> onCountChanged;
  final ValueChanged<bool> onStartWithLoremChanged;

  const LoremOptionsCard({
    super.key,
    required this.type,
    required this.count,
    required this.startWithLorem,
    required this.maxCount,
    required this.divisions,
    required this.onTypeChanged,
    required this.onCountChanged,
    required this.onStartWithLoremChanged,
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
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.type, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppDimensions.spacing12),
                Wrap(
                  spacing: AppDimensions.spacing8,
                  children: [
                    ChoiceChip(
                      label: const Text(AppStrings.words),
                      selected: type == LoremConstants.typeWords,
                      onSelected: (selected) {
                        if (selected) onTypeChanged(LoremConstants.typeWords);
                      },
                    ),
                    ChoiceChip(
                      label: const Text(AppStrings.sentences),
                      selected: type == LoremConstants.typeSentences,
                      onSelected: (selected) {
                        if (selected)
                          onTypeChanged(LoremConstants.typeSentences);
                      },
                    ),
                    ChoiceChip(
                      label: const Text(AppStrings.paragraphs),
                      selected: type == LoremConstants.typeParagraphs,
                      onSelected: (selected) {
                        if (selected)
                          onTypeChanged(LoremConstants.typeParagraphs);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.count, style: theme.textTheme.titleMedium),
                    Text(
                      count.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing12),
                Slider(
                  value: count.toDouble(),
                  min: 1,
                  max: maxCount.toDouble(),
                  divisions: divisions,
                  label: count.toString(),
                  onChanged: (value) => onCountChanged(value.round()),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          SwitchListTile(
            title: const Text(AppStrings.startWithLorem),
            subtitle: const Text(AppStrings.startWithLoremSubtitle),
            value: startWithLorem,
            onChanged: onStartWithLoremChanged,
          ),
        ],
      ),
    );
  }
}

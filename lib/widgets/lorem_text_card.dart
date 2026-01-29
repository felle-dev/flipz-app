import 'package:flutter/material.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';

class LoremTextCard extends StatelessWidget {
  final String text;
  final VoidCallback onCopy;
  final VoidCallback onGenerate;

  const LoremTextCard({
    super.key,
    required this.text,
    required this.onCopy,
    required this.onGenerate,
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
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Icon(
                  Icons.text_fields,
                  color: theme.colorScheme.primary,
                  size: AppDimensions.iconMedium,
                ),
                const SizedBox(width: AppDimensions.spacing8),
                Text(
                  AppStrings.generatedText,
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
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      text,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: onCopy,
                      icon: const Icon(Icons.copy),
                      label: const Text(AppStrings.copy),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge,
                          vertical: AppDimensions.spacing12,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacing12),
                    FilledButton.tonalIcon(
                      onPressed: onGenerate,
                      icon: const Icon(Icons.refresh),
                      label: const Text(AppStrings.generate),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge,
                          vertical: AppDimensions.spacing12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

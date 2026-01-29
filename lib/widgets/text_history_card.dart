import 'package:flutter/material.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';

class TextHistoryCard extends StatelessWidget {
  final List<String> history;
  final VoidCallback onClear;
  final ValueChanged<String> onCopy;

  const TextHistoryCard({
    super.key,
    required this.history,
    required this.onClear,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (history.isEmpty) return const SizedBox.shrink();

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
                  Icons.history,
                  color: theme.colorScheme.primary,
                  size: AppDimensions.iconMedium,
                ),
                const SizedBox(width: AppDimensions.spacing8),
                Text(
                  AppStrings.recentHistory,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onClear,
                  child: const Text(AppStrings.clear),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          ...history.reversed.map((text) {
            final isLast = text == history.reversed.last;
            final preview = text.length > 100
                ? '${text.substring(0, 100)}...'
                : text;

            return Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.text_snippet,
                        size: AppDimensions.iconMedium,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      preview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () => onCopy(text),
                    ),
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 72,
                    color: theme.colorScheme.outlineVariant,
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

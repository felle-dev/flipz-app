import 'package:flutter/material.dart';
import '../../../config/telegram_monet_constants.dart';

class ThemeCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTelegramClick;
  final VoidCallback onTelegramXClick;
  final bool isLoading;
  final String telegramLabel;
  final String telegramXLabel;

  const ThemeCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTelegramClick,
    required this.onTelegramXClick,
    required this.isLoading,
    required this.telegramLabel,
    required this.telegramXLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        borderRadius: BorderRadius.circular(TelegramMonetConstants.radiusLarge),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(TelegramMonetConstants.paddingMedium),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: TelegramMonetConstants.iconMedium,
                ),
                const SizedBox(width: TelegramMonetConstants.spacing8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(TelegramMonetConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: TelegramMonetConstants.paddingMedium),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: isLoading ? null : onTelegramClick,
                        icon: const Icon(Icons.send),
                        label: Text(telegramLabel),
                      ),
                    ),
                    const SizedBox(width: TelegramMonetConstants.spacing8),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: isLoading ? null : onTelegramXClick,
                        icon: const Icon(Icons.send),
                        label: Text(telegramXLabel),
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

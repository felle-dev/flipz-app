import 'package:flutter/material.dart';
import '../../config/telegram_monet_constants.dart';

class SettingsCardWidget extends StatelessWidget {
  final String title;
  final List<SettingItem> settings;

  const SettingsCardWidget({
    super.key,
    required this.title,
    required this.settings,
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
        children: [
          Padding(
            padding: const EdgeInsets.all(TelegramMonetConstants.paddingMedium),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
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
          ...settings
              .map((setting) => _SettingItemWidget(item: setting))
              .toList(),
        ],
      ),
    );
  }
}

class _SettingItemWidget extends StatelessWidget {
  final SettingItem item;

  const _SettingItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => item.onChanged(!item.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TelegramMonetConstants.paddingMedium,
          vertical: TelegramMonetConstants.paddingSmall,
        ),
        child: Row(
          children: [
            Expanded(child: Text(item.text, style: theme.textTheme.bodyMedium)),
            Switch(value: item.value, onChanged: item.onChanged),
          ],
        ),
      ),
    );
  }
}

class SettingItem {
  final String text;
  final bool value;
  final Function(bool) onChanged;

  const SettingItem({
    required this.text,
    required this.value,
    required this.onChanged,
  });
}

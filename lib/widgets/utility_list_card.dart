import 'package:flutter/material.dart';
import 'package:random/models/utility_item.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';

class UtilityListCard extends StatelessWidget {
  final UtilityItem item;
  final VoidCallback onTap;
  final VoidCallback onTogglePin;

  const UtilityListCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onTogglePin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onColor = _getOnColor(colorScheme, item.containerColor);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.radiusSmall),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          child: Ink(
            decoration: BoxDecoration(
              color: item.containerColor,
              borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Row(
                children: [
                  // Icon
                  SizedBox(
                    width: AppDimensions.avatarSize,
                    height: AppDimensions.avatarSize,
                    child: Icon(
                      item.icon,
                      size: AppDimensions.iconLarge,
                      color: onColor,
                    ),
                  ),

                  // Title and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: onColor,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.paddingXSmall),
                        Text(
                          item.subtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: onColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pin button
                  IconButton(
                    onPressed: onTogglePin,
                    icon: Icon(
                      item.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      color: item.isPinned
                          ? colorScheme.primary
                          : onColor.withOpacity(0.6),
                    ),
                    tooltip: item.isPinned ? AppStrings.unpin : AppStrings.pin,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getOnColor(ColorScheme colorScheme, Color containerColor) {
    if (containerColor == colorScheme.primaryContainer) {
      return colorScheme.onPrimaryContainer;
    } else if (containerColor == colorScheme.secondaryContainer) {
      return colorScheme.onSecondaryContainer;
    } else if (containerColor == colorScheme.tertiaryContainer) {
      return colorScheme.onTertiaryContainer;
    } else if (containerColor == colorScheme.errorContainer) {
      return colorScheme.onErrorContainer;
    } else {
      return colorScheme.onSurfaceVariant;
    }
  }
}

import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/random_number_constants.dart';

class NumberResultCard extends StatelessWidget {
  final int result;

  const NumberResultCard({super.key, required this.result});

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
                  Icons.tag_outlined,
                  color: theme.colorScheme.primary,
                  size: RandomNumberConstants.iconSizeSmall,
                ),
                const SizedBox(width: RandomNumberConstants.spacing8),
                Text(
                  AppStrings.randomNumberGenerated,
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
            padding: const EdgeInsets.all(RandomNumberConstants.paddingCard),
            child: Text(
              '$result',
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

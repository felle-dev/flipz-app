import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';

class UnitResultCard extends StatelessWidget {
  final String result;

  const UnitResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppDimensions.spacing12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.result,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing8),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  result.isEmpty ? '0' : result,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              if (result.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.copy, size: AppDimensions.iconMedium),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: result));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppStrings.resultCopied)),
                    );
                  },
                  color: theme.colorScheme.onPrimaryContainer,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

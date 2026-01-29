import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';

class UnitInputCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;
  final String selectedUnit;
  final List<String> units;
  final ValueChanged<String> onUnitChanged;
  final String? labelText;
  final bool showTextField;

  const UnitInputCard({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
    this.labelText,
    this.showTextField = true,
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
                  icon,
                  color: theme.colorScheme.primary,
                  size: AppDimensions.iconMedium,
                ),
                const SizedBox(width: AppDimensions.spacing8),
                Text(
                  title,
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
                if (showTextField) ...[
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: labelText ?? AppStrings.enterValue,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.spacing12,
                        ),
                      ),
                      suffixIcon: controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => controller.clear(),
                            )
                          : null,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\-?[0-9]*\.?[0-9]*'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                ],
                DropdownButtonFormField<String>(
                  value: selectedUnit,
                  decoration: InputDecoration(
                    labelText: AppStrings.unit,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.spacing12,
                      ),
                    ),
                  ),
                  items: units.map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onUnitChanged(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

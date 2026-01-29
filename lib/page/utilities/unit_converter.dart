import 'package:flutter/material.dart';
import 'package:random/controllers/unit_converter_controller.dart';
import 'package:random/config/app_strings.dart';
import 'package:random/config/app_dimensions.dart';
import 'package:random/config/unit_constants.dart';
import 'package:random/widgets/unit_input_card.dart';
import 'package:random/widgets/unit_result_card.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  final UnitConverterController _controller = UnitConverterController();
  final TextEditingController _inputController = TextEditingController();

  String _selectedCategory = UnitConstants.categoryLength;
  String _fromUnit = 'Meter';
  String _toUnit = 'Kilometer';
  String _result = '';

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convert);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    final result = _controller.convert(
      category: _selectedCategory,
      fromUnit: _fromUnit,
      toUnit: _toUnit,
      input: _inputController.text,
    );

    setState(() {
      _result = result ?? '';
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _convert();
    });
  }

  void _changeCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _fromUnit = _controller.getDefaultFromUnit(category);
      _toUnit = _controller.getDefaultToUnit(category);
      _inputController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final units = _controller.getUnitsForCategory(_selectedCategory);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.unitConverterTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          // Category Selection
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
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
                        Icons.category_outlined,
                        color: theme.colorScheme.primary,
                        size: AppDimensions.iconMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacing8),
                      Text(
                        AppStrings.category,
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
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  child: Wrap(
                    spacing: AppDimensions.spacing8,
                    runSpacing: AppDimensions.spacing8,
                    children: UnitConstants.conversions.keys.map((category) {
                      final isSelected = category == _selectedCategory;
                      return FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) _changeCategory(category);
                        },
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Input Section
          UnitInputCard(
            title: AppStrings.from,
            icon: Icons.input_outlined,
            controller: _inputController,
            selectedUnit: _fromUnit,
            units: units,
            onUnitChanged: (value) {
              setState(() => _fromUnit = value);
              _convert();
            },
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Swap Button
          Center(
            child: IconButton.filledTonal(
              onPressed: _swapUnits,
              icon: const Icon(Icons.swap_vert),
              iconSize: AppDimensions.iconLarge,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Output Section
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
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
                        Icons.output_outlined,
                        color: theme.colorScheme.primary,
                        size: AppDimensions.iconMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacing8),
                      Text(
                        AppStrings.to,
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
                      DropdownButtonFormField<String>(
                        value: _toUnit,
                        decoration: InputDecoration(
                          labelText: AppStrings.unit,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.spacing12,
                            ),
                          ),
                        ),
                        items: units.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _toUnit = value!);
                          _convert();
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      UnitResultCard(result: _result),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacing100),
        ],
      ),
    );
  }
}

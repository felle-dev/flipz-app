import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  String _selectedCategory = 'Length';
  String _fromUnit = 'Meter';
  String _toUnit = 'Kilometer';
  final TextEditingController _inputController = TextEditingController();
  String _result = '';

  final Map<String, Map<String, double>> _conversions = {
    'Length': {
      'Meter': 1.0,
      'Kilometer': 0.001,
      'Centimeter': 100.0,
      'Millimeter': 1000.0,
      'Mile': 0.000621371,
      'Yard': 1.09361,
      'Foot': 3.28084,
      'Inch': 39.3701,
    },
    'Weight': {
      'Kilogram': 1.0,
      'Gram': 1000.0,
      'Milligram': 1000000.0,
      'Pound': 2.20462,
      'Ounce': 35.274,
      'Ton': 0.001,
    },
    'Temperature': {'Celsius': 1.0, 'Fahrenheit': 1.0, 'Kelvin': 1.0},
    'Volume': {
      'Liter': 1.0,
      'Milliliter': 1000.0,
      'Gallon': 0.264172,
      'Quart': 1.05669,
      'Pint': 2.11338,
      'Cup': 4.22675,
      'Fluid Ounce': 33.814,
    },
    'Area': {
      'Square Meter': 1.0,
      'Square Kilometer': 0.000001,
      'Square Centimeter': 10000.0,
      'Square Mile': 3.861e-7,
      'Square Yard': 1.19599,
      'Square Foot': 10.7639,
      'Acre': 0.000247105,
      'Hectare': 0.0001,
    },
    'Speed': {
      'Meter/Second': 1.0,
      'Kilometer/Hour': 3.6,
      'Mile/Hour': 2.23694,
      'Foot/Second': 3.28084,
      'Knot': 1.94384,
    },
  };

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
    if (_inputController.text.isEmpty) {
      setState(() => _result = '');
      return;
    }

    final input = double.tryParse(_inputController.text);
    if (input == null) {
      setState(() => _result = 'Invalid input');
      return;
    }

    double result;
    if (_selectedCategory == 'Temperature') {
      result = _convertTemperature(input, _fromUnit, _toUnit);
    } else {
      final baseValue = input / _conversions[_selectedCategory]![_fromUnit]!;
      result = baseValue * _conversions[_selectedCategory]![_toUnit]!;
    }

    setState(() {
      _result = result
          .toStringAsFixed(6)
          .replaceAll(RegExp(r'0*$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    });
  }

  double _convertTemperature(double value, String from, String to) {
    // Convert to Celsius first
    double celsius = value;
    if (from == 'Fahrenheit') {
      celsius = (value - 32) * 5 / 9;
    } else if (from == 'Kelvin') {
      celsius = value - 273.15;
    }

    // Convert from Celsius to target
    if (to == 'Fahrenheit') {
      return celsius * 9 / 5 + 32;
    } else if (to == 'Kelvin') {
      return celsius + 273.15;
    }
    return celsius;
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
      _fromUnit = _conversions[category]!.keys.first;
      _toUnit = _conversions[category]!.keys.toList()[1];
      _inputController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final units = _conversions[_selectedCategory]!.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Category Selection
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Category',
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
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _conversions.keys.map((category) {
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
          const SizedBox(height: 16),

          // Input Section
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.input_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'From',
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _fromUnit,
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: units.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromUnit = value!;
                            _convert();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _inputController,
                        decoration: InputDecoration(
                          labelText: 'Value',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: _inputController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => _inputController.clear(),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Swap Button
          Center(
            child: IconButton.filledTonal(
              onPressed: _swapUnits,
              icon: const Icon(Icons.swap_vert),
              iconSize: 28,
            ),
          ),
          const SizedBox(height: 16),

          // Output Section
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.output_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'To',
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _toUnit,
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: units.map((unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _toUnit = value!;
                            _convert();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Result',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: SelectableText(
                                    _result.isEmpty ? '0' : _result,
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'monospace',
                                          color: theme
                                              .colorScheme
                                              .onPrimaryContainer,
                                        ),
                                  ),
                                ),
                                if (_result.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.copy, size: 20),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: _result),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Result copied!'),
                                        ),
                                      );
                                    },
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

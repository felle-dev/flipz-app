import 'package:flipz/config/unit_constants.dart';

class UnitConverterController {
  String? convert({
    required String category,
    required String fromUnit,
    required String toUnit,
    required String input,
  }) {
    if (input.isEmpty) return null;

    final value = double.tryParse(input);
    if (value == null) return 'Invalid input';

    double result;
    if (category == UnitConstants.categoryTemperature) {
      result = _convertTemperature(value, fromUnit, toUnit);
    } else {
      final baseValue = value / UnitConstants.conversions[category]![fromUnit]!;
      result = baseValue * UnitConstants.conversions[category]![toUnit]!;
    }

    return result
        .toStringAsFixed(UnitConstants.resultDecimalPlaces)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
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

  List<String> getUnitsForCategory(String category) {
    return UnitConstants.conversions[category]!.keys.toList();
  }

  String getDefaultFromUnit(String category) {
    return UnitConstants.conversions[category]!.keys.first;
  }

  String getDefaultToUnit(String category) {
    return UnitConstants.conversions[category]!.keys.toList()[1];
  }
}

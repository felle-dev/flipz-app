class UnitConstants {
  static const Map<String, Map<String, double>> conversions = {
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

  static const String categoryLength = 'Length';
  static const String categoryWeight = 'Weight';
  static const String categoryTemperature = 'Temperature';
  static const String categoryVolume = 'Volume';
  static const String categoryArea = 'Area';
  static const String categorySpeed = 'Speed';

  static const int resultDecimalPlaces = 6;
}

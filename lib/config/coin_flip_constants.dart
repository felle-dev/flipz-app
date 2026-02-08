import 'dart:math';

/// Configuration constants for Coin Flip feature
class CoinFlipConstants {
  // Animation durations
  static const int animationDurationMs = 800;

  // Animation values
  static const double rotationMultiplier = 4.0; // pi * 4 for full rotation
  static const double perspectiveValue = 0.001;
  static const int perspectiveEntry = 3;
  static const int perspectiveRow = 2;

  // Coin dimensions
  static const double coinSize = 150.0;
  static const double coinIconSize = 80.0;

  // UI spacing
  static const double paddingPage = 20.0;
  static const double paddingCard = 40.0;
  static const double spacingMedium = 40.0;
  static const double spacingSmall = 32.0;

  // Button padding
  static const double buttonPaddingHorizontal = 32.0;
  static const double buttonPaddingVertical = 16.0;

  // Coin result values
  static const String resultHeads = 'Heads';
  static const String resultTails = 'Tails';

  // Helper method to get random coin result
  static String getRandomResult() {
    return Random().nextBool() ? resultHeads : resultTails;
  }
}

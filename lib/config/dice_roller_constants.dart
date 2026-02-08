/// Configuration constants for Dice Roller feature
class DiceRollerConstants {
  // Animation durations
  static const int animationDurationMs = 500;

  // Dice settings
  static const int minNumberOfDice = 1;
  static const int maxNumberOfDice = 10;
  static const int defaultNumberOfDice = 1;
  static const int defaultSides = 6;

  // Available dice types
  static const List<int> availableSides = [4, 6, 8, 10, 12, 20];

  // UI dimensions
  static const double paddingPage = 20.0;
  static const double paddingCard = 32.0;
  static const double paddingCardHeader = 16.0;
  static const double paddingCardContent = 20.0;

  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing12 = 12.0;
  static const double spacing8 = 8.0;

  static const double borderRadius = 16.0;
  static const double borderWidth = 1.0;

  // Dice result display
  static const double diceSize = 60.0;
  static const double diceBorderRadius = 12.0;
  static const double diceSpacing = 12.0;

  // Icon sizes
  static const double iconSizeLarge = 80.0;
  static const double iconSizeSmall = 20.0;

  // Button padding
  static const double buttonPaddingHorizontal = 32.0;
  static const double buttonPaddingVertical = 16.0;

  // Bottom spacing
  static const double bottomSpacing = 100.0;

  // Slider divisions
  static const int sliderDivisions = 9; // max - min
}

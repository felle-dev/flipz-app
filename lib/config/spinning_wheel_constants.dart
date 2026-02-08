/// Configuration constants for Spinning Wheel feature
class SpinningWheelConstants {
  // Animation settings
  static const int animationDurationMs = 15000;
  static const double minSpins = 5.0;
  static const double maxAdditionalSpins = 3.0;

  // Wheel dimensions
  static const double wheelSize = 300.0;
  static const double wheelPadding = 20.0;
  static const double arrowSize = 40.0;
  static const double arrowSpacing = 10.0;

  // Wheel center circle
  static const double centerCircleRadius = 20.0;

  // Wheel colors
  static const double colorHueSaturation = 0.7;
  static const double colorHueLightness = 0.6;

  // Section border
  static const double sectionBorderWidth = 2.0;

  // Text settings
  static const double textRadiusSmall = 0.75; // For 20+ options
  static const double textRadiusMedium = 0.72; // For 15-20 options
  static const double textRadiusNormal = 0.70; // For 10-15 options
  static const double textRadiusLarge = 0.68; // For 8-10 options
  static const double textRadiusDefault = 0.70; // For <8 options

  static const double fontSizeSmall = 8.0; // For 20+ options
  static const double fontSizeMedium = 10.0; // For 15-20 options
  static const double fontSizeNormal = 12.0; // For 10-15 options
  static const double fontSizeLarge = 14.0; // For 8-10 options
  static const double fontSizeDefault = 16.0; // For <8 options

  // Constraints
  static const int minOptions = 2;
  static const double optionListMaxHeight = 300.0;

  // UI dimensions
  static const double paddingPage = 20.0;
  static const double paddingCard = 16.0;
  static const double paddingCardContent = 20.0;

  static const double spacing24 = 24.0;
  static const double spacing16 = 16.0;
  static const double spacing12 = 12.0;
  static const double spacing8 = 8.0;
  static const double spacing6 = 6.0;

  static const double borderRadius = 16.0;
  static const double borderWidth = 1.0;
  static const double borderRadiusDialog = 20.0;
  static const double borderRadiusResult = 12.0;

  // Icon sizes
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 48.0;
  static const double iconSizeLarge = 80.0;

  // Dialog dimensions
  static const double dialogPadding = 32.0;
  static const double dialogIconSize = 80.0;
  static const double resultPaddingHorizontal = 24.0;
  static const double resultPaddingVertical = 16.0;

  // Color indicator
  static const double colorIndicatorSize = 24.0;
  static const double colorIndicatorBorder = 2.0;

  // Button padding
  static const double buttonPaddingHorizontal = 32.0;
  static const double buttonPaddingVertical = 16.0;
  static const double buttonPaddingSmallHorizontal = 16.0;
  static const double buttonPaddingSmallVertical = 8.0;
  static const double buttonPaddingDialogVertical = 12.0;

  // Bottom spacing
  static const double bottomSpacing = 100.0;

  // Default options
  static const List<String> defaultOptions = [
    'Sheep',
    'Goat',
    'Lamp',
    'Chair',
    'Table',
    'Pillow',
    'Blanket',
    'Mop',
    'Broom',
    'Vacuum',
    'Blender',
    'Microwave',
    'Fridge',
    'Teapot',
    'Kettle',
    'Umbrella',
    'Backpack',
    'Shoe',
    'Hat',
    'Glove',
    'Scarf',
    'Balloon',
    'Crayon',
    'Pencil',
    'Eraser',
    'Stapler',
    'Scissors',
    'Tape',
    'Button',
    'Zipper',
  ];
}

/// Configuration constants for Telegram Monet Theme feature
class TelegramMonetConstants {
  // URLs
  static const String urlAbout =
      'https://github.com/mi-g-alex/Telegram-Monet/blob/main/README.md';
  static const String urlTelegram = 'https://t.me/tgmonet';
  static const String urlGithub = 'https://github.com/mi-g-alex/Telegram-Monet';

  // Input theme files
  static const String inputFileTelegramLight =
      'assets/themes/monet_light.attheme';
  static const String inputFileTelegramDark =
      'assets/themes/monet_dark.attheme';
  static const String inputFileTelegramXLight =
      'assets/themes/monet_x_light.tgx-theme';
  static const String inputFileTelegramXDark =
      'assets/themes/monet_x_dark.tgx-theme';

  // Output theme files
  static const String outputFileTelegramLight = 'Light Theme.attheme';
  static const String outputFileTelegramDark = 'Dark Theme.attheme';
  static const String outputFileTelegramAmoled = 'Amoled Theme.attheme';
  static const String outputFileTelegramXLight = 'Light Theme.tgx-theme';
  static const String outputFileTelegramXDark = 'Dark Theme.tgx-theme';
  static const String outputFileTelegramXAmoled = 'Amoled Theme.tgx-theme';

  // SharedPreferences keys
  static const String sharedIsAmoled = 'isAmoledMode';
  static const String sharedUseGradient = 'useGradient';
  static const String sharedUseGradientAvatars = 'useGradientAvatars';
  static const String sharedUseColorfulNickname = 'useColorNick';
  static const String sharedUseOldChatStyle = 'useOldChatStyle';

  // Platform channel
  static const String platformChannel = 'telegram_monet/colors';
  static const String methodGetMonetColors = 'getMonetColors';

  // Theme replacement strings
  static const String noGradientKey = 'noGradient';
  static const String chatOutBubbleGradient = 'chat_outBubbleGradient';

  // Telegram color keys
  static const List<String> telegramColorKeys = [
    'chat_outBubble',
    'chat_outBubbleGradient',
    'chat_outBubbleGradientSelectedOverlay',
    'chat_outBubbleSelectedOverlay',
  ];

  // Telegram X color keys
  static const List<String> telegramXColorKeys = [
    'bubbleOut_background',
    'bubbleOut_outline',
  ];

  // Avatar background keys
  static const List<String> avatarBackgroundKeys = [
    'avatar_backgroundBlue',
    'avatar_backgroundCyan',
    'avatar_backgroundGreen',
    'avatar_backgroundOrange',
    'avatar_backgroundPink',
    'avatar_backgroundRed',
    'avatar_backgroundSaved',
    'avatar_backgroundViolet',
  ];

  // Color values
  static const int colorMonetRedDark = 0xFFF2B8B5;
  static const int colorMonetRedLight = 0xFFB3261E;
  static const int colorMonetRedCall = 0xFFEF5350;
  static const int colorMonetGreenCall = 0xFF4CAF50;

  // Color replacement patterns
  static const String colorN1_900 = 'n1_900';
  static const String colorN1_1000 = 'n1_1000';
  static const String colorN2_800 = 'n2_800';
  static const String colorN2_700 = 'n2_700';

  // Monet color keys
  static const String monetRedDark = 'monetRedDark';
  static const String monetRedLight = 'monetRedLight';
  static const String monetRedCall = 'monetRedCall';
  static const String monetGreenCall = 'monetGreenCall';

  // Share text
  static const String shareSubject = 'Telegram Monet Theme';

  // UI dimensions
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double spacing8 = 8.0;
  static const double radiusLarge = 32.0;
  static const double iconMedium = 24.0;

  // Theme template markers
  static const String endMarker = '\nend';
  static const String dollarSign = '\$';
  static const String newline = '\n';

  // Separator characters
  static const String telegramSeparator = '=';
  static const String telegramXSeparator = ':';
}

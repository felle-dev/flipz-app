import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// ==================== CONSTANTS ====================

class TelegramMonetConstants {
  static const String urlAbout =
      'https://github.com/mi-g-alex/Telegram-Monet/blob/main/README.md';
  static const String urlTelegram = 'https://t.me/tgmonet';
  static const String urlGithub = 'https://github.com/mi-g-alex/Telegram-Monet';

  static const String inputFileTelegramLight =
      'assets/themes/monet_light.attheme';
  static const String inputFileTelegramDark =
      'assets/themes/monet_dark.attheme';
  static const String inputFileTelegramXLight =
      'assets/themes/monet_x_light.tgx-theme';
  static const String inputFileTelegramXDark =
      'assets/themes/monet_x_dark.tgx-theme';

  static const String outputFileTelegramLight = 'Light Theme.attheme';
  static const String outputFileTelegramDark = 'Dark Theme.attheme';
  static const String outputFileTelegramAmoled = 'Amoled Theme.attheme';
  static const String outputFileTelegramXLight = 'Light Theme.tgx-theme';
  static const String outputFileTelegramXDark = 'Dark Theme.tgx-theme';
  static const String outputFileTelegramXAmoled = 'Amoled Theme.tgx-theme';

  static const String sharedIsAmoled = 'isAmoledMode';
  static const String sharedUseGradient = 'useGradient';
  static const String sharedUseGradientAvatars = 'useGradientAvatars';
  static const String sharedUseColorfulNickname = 'useColorNick';
  static const String sharedUseOldChatStyle = 'useOldChatStyle';

  static const String appTitle = 'TG Monet Theme';
  static const String lightTheme = 'Light';
  static const String darkTheme = 'Dark';
  static const String lightDescription =
      'Make light theme from system shades. Looks good during the day.';
  static const String darkDescription =
      'Make dark theme from system shades. Great for the night.';
  static const String settings = 'Settings';
  static const String amoledMode = 'Amoled mode';
  static const String enableGradient = 'Enable gradient (Telegram)';
  static const String enableGradientAvatars = 'Enable gradient for avatars';
  static const String enableMonetNicknames = 'Enable monet for nicknames';
  static const String useAltOutgoingStyle =
      'Use alternative outgoing message style';
  static const String telegram = 'Telegram';
  static const String telegramX = 'Telegram X';
}

class PageDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double spacing8 = 8.0;
  static const double radiusLarge = 32.0;
  static const double iconMedium = 24.0;
}

// ==================== SERVICES ====================

class ThemeGeneratorService {
  static const MethodChannel _channel = MethodChannel('telegram_monet/colors');

  Future<File> createTheme({
    required BuildContext context,
    required bool isTelegram,
    required bool isAmoled,
    required bool isGradient,
    required bool isAvatarGradient,
    required bool isNicknameColorful,
    required bool isAlterOutColor,
    required String inputFileName,
    required String outputFileName,
  }) async {
    String themeTemplate = await rootBundle.loadString(inputFileName);
    List<String> listMain = themeTemplate.split('\n');

    if (isGradient) {
      for (int i = 0; i < listMain.length; i++) {
        listMain[i] = listMain[i].replaceAll(
          'noGradient',
          'chat_outBubbleGradient',
        );
      }
    }

    if (isAlterOutColor) {
      String inputSecondFileName;
      if (isTelegram) {
        inputSecondFileName =
            inputFileName == TelegramMonetConstants.inputFileTelegramLight
            ? TelegramMonetConstants.inputFileTelegramDark
            : TelegramMonetConstants.inputFileTelegramLight;
      } else {
        inputSecondFileName =
            inputFileName == TelegramMonetConstants.inputFileTelegramXLight
            ? TelegramMonetConstants.inputFileTelegramXDark
            : TelegramMonetConstants.inputFileTelegramXLight;
      }

      String secondThemeTemplate = await rootBundle.loadString(
        inputSecondFileName,
      );
      List<String> listSecond = secondThemeTemplate.split('\n');

      final listToReplace = isTelegram
          ? [
              'chat_outBubble',
              'chat_outBubbleGradient',
              'chat_outBubbleGradientSelectedOverlay',
              'chat_outBubbleSelectedOverlay',
            ]
          : ['bubbleOut_background', 'bubbleOut_outline'];

      for (String value in listToReplace) {
        final separator = isTelegram ? '=' : ':';
        final index1 = listMain.indexWhere(
          (line) => line.startsWith('$value$separator'),
        );
        final index2 = listSecond.indexWhere(
          (line) => line.startsWith('$value$separator'),
        );

        if (index1 >= 0 && index2 >= 0) {
          listMain[index1] = listSecond[index2];
        }
      }
    }

    String themeImport = listMain.join('\n');

    if (isAmoled) {
      print('🌑 AMOLED MODE ENABLED');
      print('   Before: ${themeImport.contains('n1_900')}');
      print(
        '   Count of n1_900: ${RegExp('n1_900').allMatches(themeImport).length}',
      );

      themeImport = themeImport.replaceAll('n1_900', 'n1_1000');

      print('   After: ${themeImport.contains('n1_900')}');
      print(
        '   Count of n1_1000: ${RegExp('n1_1000').allMatches(themeImport).length}',
      );
    }

    if (isTelegram && isNicknameColorful) {
      themeImport = themeImport.replaceAll(
        '\nend',
        '\navatar_nameInMessageBlue=a1_400\n'
            'avatar_nameInMessageCyan=a1_400\n'
            'avatar_nameInMessageGreen=a1_400\n'
            'avatar_nameInMessageOrange=a1_400\n'
            'avatar_nameInMessagePink=a1_400\n'
            'avatar_nameInMessageRed=a1_400\n'
            'avatar_nameInMessageViolet=a1_400\nend',
      );
    }

    if (isTelegram && isAvatarGradient) {
      themeImport = themeImport
          .replaceAll(
            'avatar_backgroundBlue=n2_800',
            'avatar_backgroundBlue=n2_700',
          )
          .replaceAll(
            'avatar_backgroundCyan=n2_800',
            'avatar_backgroundCyan=n2_700',
          )
          .replaceAll(
            'avatar_backgroundGreen=n2_800',
            'avatar_backgroundGreen=n2_700',
          )
          .replaceAll(
            'avatar_backgroundOrange=n2_800',
            'avatar_backgroundOrange=n2_700',
          )
          .replaceAll(
            'avatar_backgroundPink=n2_800',
            'avatar_backgroundPink=n2_700',
          )
          .replaceAll(
            'avatar_backgroundRed=n2_800',
            'avatar_backgroundRed=n2_700',
          )
          .replaceAll(
            'avatar_backgroundSaved=n2_800',
            'avatar_backgroundSaved=n2_700',
          )
          .replaceAll(
            'avatar_backgroundViolet=n2_800',
            'avatar_backgroundViolet=n2_700',
          );
    }

    final generatedTheme = await _replaceMonetColors(themeImport, isAmoled);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$outputFileName');
    await file.writeAsString(generatedTheme);

    return file;
  }

  Future<String> _replaceMonetColors(String fileContent, bool isAmoled) async {
    try {
      final Map<dynamic, dynamic> rawColors = await _channel.invokeMethod(
        'getMonetColors',
      );

      final Map<String, String> monetColors = {};
      rawColors.forEach((key, value) {
        monetColors[key.toString()] = value.toString();
      });

      // Add special colors
      monetColors['monetRedDark'] = _colorToArgbString(const Color(0xFFF2B8B5));
      monetColors['monetRedLight'] = _colorToArgbString(
        const Color(0xFFB3261E),
      );
      monetColors['monetRedCall'] = _colorToArgbString(const Color(0xFFEF5350));
      monetColors['monetGreenCall'] = _colorToArgbString(
        const Color(0xFF4CAF50),
      );

      String result = fileContent.replaceAll('\$', '');

      // FIX: Sort keys by length (longest first) to avoid partial matches
      final sortedKeys = monetColors.keys.toList()
        ..sort((a, b) => b.length.compareTo(a.length));

      for (String key in sortedKeys) {
        result = result.replaceAll(key, monetColors[key]!);
      }

      if (isAmoled) {
        final n1_900_value = monetColors['n1_900']!;
        final n1_1000_value = monetColors['n1_1000']!;
        result = result.replaceAll(n1_900_value, n1_1000_value);
      }

      // In _replaceMonetColors, after creating monetColors map:
      print('🎨 Background colors:');
      print('   n1_0 = ${monetColors['n1_0']}');
      print('   n1_900 = ${monetColors['n1_900']}');
      print('   n1_1000 = ${monetColors['n1_1000']}');

      return result;
    } catch (e) {
      print('⚠️ Platform channel failed: $e');
      return fileContent.replaceAll('\$', '');
    }
  }

  String _colorToArgbString(Color color) {
    final int argb =
        (color.alpha << 24) |
        (color.red << 16) |
        (color.green << 8) |
        color.blue;
    return argb.toSigned(32).toString();
  }
}

// ==================== MAIN PAGE ====================

class TelegramMonetPage extends StatefulWidget {
  const TelegramMonetPage({super.key});

  @override
  State<TelegramMonetPage> createState() => _TelegramMonetPageState();
}

class _TelegramMonetPageState extends State<TelegramMonetPage> {
  final ThemeGeneratorService _themeGenerator = ThemeGeneratorService();

  bool _isAmoled = false;
  bool _isGradient = false;
  bool _isAvatarGradient = false;
  bool _isNicknameColorful = true;
  bool _isAlterOutColor = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAmoled = prefs.getBool(TelegramMonetConstants.sharedIsAmoled) ?? false;
      _isGradient =
          prefs.getBool(TelegramMonetConstants.sharedUseGradient) ?? false;
      _isAvatarGradient =
          prefs.getBool(TelegramMonetConstants.sharedUseGradientAvatars) ??
          false;
      _isNicknameColorful =
          prefs.getBool(TelegramMonetConstants.sharedUseColorfulNickname) ??
          true;
      _isAlterOutColor =
          prefs.getBool(TelegramMonetConstants.sharedUseOldChatStyle) ?? true;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _onShareTheme(bool isTelegram, bool isLight) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final String inputFileName = _getInputFileName(isTelegram, isLight);
      final String outputFileName = _getOutputFileName(isTelegram, isLight);

      final File themeFile = await _themeGenerator.createTheme(
        context: context,
        isTelegram: isTelegram,
        isAmoled: _isAmoled,
        isGradient: _isGradient,
        isAvatarGradient: _isAvatarGradient,
        isNicknameColorful: _isNicknameColorful,
        isAlterOutColor: _isAlterOutColor,
        inputFileName: inputFileName,
        outputFileName: outputFileName,
      );

      final XFile xFile = XFile(themeFile.path);
      await Share.shareXFiles(
        [xFile],
        subject: outputFileName,
        text: 'Telegram Monet Theme',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getInputFileName(bool isTelegram, bool isLight) {
    if (isTelegram && isLight)
      return TelegramMonetConstants.inputFileTelegramLight;
    if (isTelegram) return TelegramMonetConstants.inputFileTelegramDark;
    if (!isTelegram && isLight)
      return TelegramMonetConstants.inputFileTelegramXLight;
    return TelegramMonetConstants.inputFileTelegramXDark;
  }

  String _getOutputFileName(bool isTelegram, bool isLight) {
    if (isTelegram && isLight)
      return TelegramMonetConstants.outputFileTelegramLight;
    if (isTelegram && !_isAmoled)
      return TelegramMonetConstants.outputFileTelegramDark;
    if (isTelegram) return TelegramMonetConstants.outputFileTelegramAmoled;
    if (!isTelegram && isLight)
      return TelegramMonetConstants.outputFileTelegramXLight;
    if (!isTelegram && !_isAmoled)
      return TelegramMonetConstants.outputFileTelegramXDark;
    return TelegramMonetConstants.outputFileTelegramXAmoled;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(TelegramMonetConstants.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(PageDimensions.paddingMedium),
        children: [
          _buildThemeCard(
            theme: theme,
            title: TelegramMonetConstants.lightTheme,
            description: TelegramMonetConstants.lightDescription,
            icon: Icons.light_mode,
            onTelegramClick: () => _onShareTheme(true, true),
            onTelegramXClick: () => _onShareTheme(false, true),
          ),
          const SizedBox(height: PageDimensions.paddingMedium),
          _buildThemeCard(
            theme: theme,
            title: TelegramMonetConstants.darkTheme,
            description: TelegramMonetConstants.darkDescription,
            icon: Icons.dark_mode,
            onTelegramClick: () => _onShareTheme(true, false),
            onTelegramXClick: () => _onShareTheme(false, false),
          ),
          const SizedBox(height: PageDimensions.paddingMedium),
          _buildSettingsCard(theme),
        ],
      ),
    );
  }

  Widget _buildThemeCard({
    required ThemeData theme,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTelegramClick,
    required VoidCallback onTelegramXClick,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        borderRadius: BorderRadius.circular(PageDimensions.radiusLarge),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(PageDimensions.paddingMedium),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: PageDimensions.iconMedium,
                ),
                const SizedBox(width: PageDimensions.spacing8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(PageDimensions.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: PageDimensions.paddingMedium),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _isLoading ? null : onTelegramClick,
                        icon: const Icon(Icons.send),
                        label: const Text(TelegramMonetConstants.telegram),
                      ),
                    ),
                    const SizedBox(width: PageDimensions.spacing8),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: _isLoading ? null : onTelegramXClick,
                        icon: const Icon(Icons.send),
                        label: const Text(TelegramMonetConstants.telegramX),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(ThemeData theme) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
        borderRadius: BorderRadius.circular(PageDimensions.radiusLarge),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(PageDimensions.paddingMedium),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: theme.colorScheme.primary,
                  size: PageDimensions.iconMedium,
                ),
                const SizedBox(width: PageDimensions.spacing8),
                Text(
                  TelegramMonetConstants.settings,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          _buildSettingItem(
            theme,
            TelegramMonetConstants.amoledMode,
            _isAmoled,
            (value) {
              setState(() => _isAmoled = value);
              _saveSetting(TelegramMonetConstants.sharedIsAmoled, value);
            },
          ),
          _buildSettingItem(
            theme,
            TelegramMonetConstants.enableGradient,
            _isGradient,
            (value) {
              setState(() => _isGradient = value);
              _saveSetting(TelegramMonetConstants.sharedUseGradient, value);
            },
          ),
          _buildSettingItem(
            theme,
            TelegramMonetConstants.enableGradientAvatars,
            _isAvatarGradient,
            (value) {
              setState(() => _isAvatarGradient = value);
              _saveSetting(
                TelegramMonetConstants.sharedUseGradientAvatars,
                value,
              );
            },
          ),
          _buildSettingItem(
            theme,
            TelegramMonetConstants.enableMonetNicknames,
            _isNicknameColorful,
            (value) {
              setState(() => _isNicknameColorful = value);
              _saveSetting(
                TelegramMonetConstants.sharedUseColorfulNickname,
                value,
              );
            },
          ),
          _buildSettingItem(
            theme,
            TelegramMonetConstants.useAltOutgoingStyle,
            _isAlterOutColor,
            (value) {
              setState(() => _isAlterOutColor = value);
              _saveSetting(TelegramMonetConstants.sharedUseOldChatStyle, value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    ThemeData theme,
    String text,
    bool value,
    Function(bool) onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PageDimensions.paddingMedium,
          vertical: PageDimensions.paddingSmall,
        ),
        child: Row(
          children: [
            Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../../../config/telegram_monet_constants.dart';

/// Service for generating Telegram Monet themes
class ThemeGeneratorService {
  static const MethodChannel _channel = MethodChannel(
    TelegramMonetConstants.platformChannel,
  );

  /// Creates a theme file based on the provided configuration
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
    List<String> listMain = themeTemplate.split(TelegramMonetConstants.newline);

    // Apply gradient if enabled
    if (isGradient) {
      listMain = _applyGradient(listMain);
    }

    // Apply alternative outgoing color if enabled
    if (isAlterOutColor) {
      listMain = await _applyAlternativeOutgoingColor(
        listMain,
        isTelegram,
        inputFileName,
      );
    }

    String themeImport = listMain.join(TelegramMonetConstants.newline);

    // Apply AMOLED mode
    if (isAmoled) {
      themeImport = _applyAmoledMode(themeImport);
    }

    // Apply colorful nicknames (Telegram only)
    if (isTelegram && isNicknameColorful) {
      themeImport = _applyColorfulNicknames(themeImport);
    }

    // Apply avatar gradient (Telegram only)
    if (isTelegram && isAvatarGradient) {
      themeImport = _applyAvatarGradient(themeImport);
    }

    // Replace monet color placeholders with actual colors
    final generatedTheme = await _replaceMonetColors(themeImport, isAmoled);

    // Save to file
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$outputFileName');
    await file.writeAsString(generatedTheme);

    return file;
  }

  /// Applies gradient to the theme
  List<String> _applyGradient(List<String> lines) {
    return lines.map((line) {
      return line.replaceAll(
        TelegramMonetConstants.noGradientKey,
        TelegramMonetConstants.chatOutBubbleGradient,
      );
    }).toList();
  }

  /// Applies alternative outgoing message color
  Future<List<String>> _applyAlternativeOutgoingColor(
    List<String> listMain,
    bool isTelegram,
    String inputFileName,
  ) async {
    // Determine the opposite theme file
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
    List<String> listSecond = secondThemeTemplate.split(
      TelegramMonetConstants.newline,
    );

    // Get the appropriate color keys based on app type
    final listToReplace = isTelegram
        ? TelegramMonetConstants.telegramColorKeys
        : TelegramMonetConstants.telegramXColorKeys;

    final separator = isTelegram
        ? TelegramMonetConstants.telegramSeparator
        : TelegramMonetConstants.telegramXSeparator;

    // Replace colors from the opposite theme
    for (String value in listToReplace) {
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

    return listMain;
  }

  /// Applies AMOLED mode (pure black background)
  String _applyAmoledMode(String themeContent) {
    debugPrint('🌑 AMOLED MODE ENABLED');
    debugPrint(
      '   Before: ${themeContent.contains(TelegramMonetConstants.colorN1_900)}',
    );
    debugPrint(
      '   Count of ${TelegramMonetConstants.colorN1_900}: ${RegExp(TelegramMonetConstants.colorN1_900).allMatches(themeContent).length}',
    );

    final result = themeContent.replaceAll(
      TelegramMonetConstants.colorN1_900,
      TelegramMonetConstants.colorN1_1000,
    );

    debugPrint(
      '   After: ${result.contains(TelegramMonetConstants.colorN1_900)}',
    );
    debugPrint(
      '   Count of ${TelegramMonetConstants.colorN1_1000}: ${RegExp(TelegramMonetConstants.colorN1_1000).allMatches(result).length}',
    );

    return result;
  }

  /// Applies colorful nicknames (Telegram only)
  String _applyColorfulNicknames(String themeContent) {
    return themeContent.replaceAll(
      TelegramMonetConstants.endMarker,
      '${TelegramMonetConstants.newline}avatar_nameInMessageBlue=a1_400\n'
      'avatar_nameInMessageCyan=a1_400\n'
      'avatar_nameInMessageGreen=a1_400\n'
      'avatar_nameInMessageOrange=a1_400\n'
      'avatar_nameInMessagePink=a1_400\n'
      'avatar_nameInMessageRed=a1_400\n'
      'avatar_nameInMessageViolet=a1_400${TelegramMonetConstants.endMarker}',
    );
  }

  /// Applies gradient to avatars (Telegram only)
  String _applyAvatarGradient(String themeContent) {
    String result = themeContent;

    for (String key in TelegramMonetConstants.avatarBackgroundKeys) {
      result = result.replaceAll(
        '$key=${TelegramMonetConstants.colorN2_800}',
        '$key=${TelegramMonetConstants.colorN2_700}',
      );
    }

    return result;
  }

  /// Replaces monet color placeholders with actual system colors
  Future<String> _replaceMonetColors(String fileContent, bool isAmoled) async {
    try {
      final Map<dynamic, dynamic> rawColors = await _channel.invokeMethod(
        TelegramMonetConstants.methodGetMonetColors,
      );

      final Map<String, String> monetColors = {};
      rawColors.forEach((key, value) {
        monetColors[key.toString()] = value.toString();
      });

      // Add special colors
      monetColors[TelegramMonetConstants.monetRedDark] = _colorToArgbString(
        const Color(TelegramMonetConstants.colorMonetRedDark),
      );
      monetColors[TelegramMonetConstants.monetRedLight] = _colorToArgbString(
        const Color(TelegramMonetConstants.colorMonetRedLight),
      );
      monetColors[TelegramMonetConstants.monetRedCall] = _colorToArgbString(
        const Color(TelegramMonetConstants.colorMonetRedCall),
      );
      monetColors[TelegramMonetConstants.monetGreenCall] = _colorToArgbString(
        const Color(TelegramMonetConstants.colorMonetGreenCall),
      );

      String result = fileContent.replaceAll(
        TelegramMonetConstants.dollarSign,
        '',
      );

      // Sort keys by length (longest first) to avoid partial matches
      final sortedKeys = monetColors.keys.toList()
        ..sort((a, b) => b.length.compareTo(a.length));

      // Replace color placeholders
      for (String key in sortedKeys) {
        result = result.replaceAll(key, monetColors[key]!);
      }

      // Apply AMOLED color replacement if needed
      if (isAmoled) {
        final n1_900_value = monetColors[TelegramMonetConstants.colorN1_900]!;
        final n1_1000_value = monetColors[TelegramMonetConstants.colorN1_1000]!;
        result = result.replaceAll(n1_900_value, n1_1000_value);
      }

      debugPrint('🎨 Background colors:');
      debugPrint('   n1_0 = ${monetColors['n1_0']}');
      debugPrint(
        '   ${TelegramMonetConstants.colorN1_900} = ${monetColors[TelegramMonetConstants.colorN1_900]}',
      );
      debugPrint(
        '   ${TelegramMonetConstants.colorN1_1000} = ${monetColors[TelegramMonetConstants.colorN1_1000]}',
      );

      return result;
    } catch (e) {
      debugPrint('⚠️ Platform channel failed: $e');
      return fileContent.replaceAll(TelegramMonetConstants.dollarSign, '');
    }
  }

  /// Converts a Color to ARGB string format
  String _colorToArgbString(Color color) {
    final int argb =
        (color.alpha << 24) |
        (color.red << 16) |
        (color.green << 8) |
        color.blue;
    return argb.toSigned(32).toString();
  }
}

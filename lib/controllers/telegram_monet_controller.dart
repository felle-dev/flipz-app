import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/telegram_monet_constants.dart';
import '../utils/theme_generator_service.dart';

class TelegramMonetController extends ChangeNotifier {
  final ThemeGeneratorService _themeGenerator = ThemeGeneratorService();

  bool _isAmoled = false;
  bool _isGradient = false;
  bool _isAvatarGradient = false;
  bool _isNicknameColorful = true;
  bool _isAlterOutColor = true;
  bool _isLoading = false;

  // Getters
  bool get isAmoled => _isAmoled;
  bool get isGradient => _isGradient;
  bool get isAvatarGradient => _isAvatarGradient;
  bool get isNicknameColorful => _isNicknameColorful;
  bool get isAlterOutColor => _isAlterOutColor;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    await loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isAmoled = prefs.getBool(TelegramMonetConstants.sharedIsAmoled) ?? false;
    _isGradient =
        prefs.getBool(TelegramMonetConstants.sharedUseGradient) ?? false;
    _isAvatarGradient =
        prefs.getBool(TelegramMonetConstants.sharedUseGradientAvatars) ?? false;
    _isNicknameColorful =
        prefs.getBool(TelegramMonetConstants.sharedUseColorfulNickname) ?? true;
    _isAlterOutColor =
        prefs.getBool(TelegramMonetConstants.sharedUseOldChatStyle) ?? true;
    notifyListeners();
  }

  Future<void> setAmoled(bool value) async {
    _isAmoled = value;
    await _saveSetting(TelegramMonetConstants.sharedIsAmoled, value);
    notifyListeners();
  }

  Future<void> setGradient(bool value) async {
    _isGradient = value;
    await _saveSetting(TelegramMonetConstants.sharedUseGradient, value);
    notifyListeners();
  }

  Future<void> setAvatarGradient(bool value) async {
    _isAvatarGradient = value;
    await _saveSetting(TelegramMonetConstants.sharedUseGradientAvatars, value);
    notifyListeners();
  }

  Future<void> setNicknameColorful(bool value) async {
    _isNicknameColorful = value;
    await _saveSetting(TelegramMonetConstants.sharedUseColorfulNickname, value);
    notifyListeners();
  }

  Future<void> setAlterOutColor(bool value) async {
    _isAlterOutColor = value;
    await _saveSetting(TelegramMonetConstants.sharedUseOldChatStyle, value);
    notifyListeners();
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<ShareThemeResult> shareTheme({
    required bool isTelegram,
    required bool isLight,
    required dynamic context,
  }) async {
    if (_isLoading) {
      return ShareThemeResult(
        success: false,
        error: 'Theme generation already in progress',
      );
    }

    _isLoading = true;
    notifyListeners();

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
        text: TelegramMonetConstants.shareSubject,
      );

      _isLoading = false;
      notifyListeners();

      return ShareThemeResult(success: true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return ShareThemeResult(success: false, error: e.toString());
    }
  }

  String _getInputFileName(bool isTelegram, bool isLight) {
    if (isTelegram && isLight) {
      return TelegramMonetConstants.inputFileTelegramLight;
    }
    if (isTelegram) {
      return TelegramMonetConstants.inputFileTelegramDark;
    }
    if (!isTelegram && isLight) {
      return TelegramMonetConstants.inputFileTelegramXLight;
    }
    return TelegramMonetConstants.inputFileTelegramXDark;
  }

  String _getOutputFileName(bool isTelegram, bool isLight) {
    if (isTelegram && isLight) {
      return TelegramMonetConstants.outputFileTelegramLight;
    }
    if (isTelegram && !_isAmoled) {
      return TelegramMonetConstants.outputFileTelegramDark;
    }
    if (isTelegram) {
      return TelegramMonetConstants.outputFileTelegramAmoled;
    }
    if (!isTelegram && isLight) {
      return TelegramMonetConstants.outputFileTelegramXLight;
    }
    if (!isTelegram && !_isAmoled) {
      return TelegramMonetConstants.outputFileTelegramXDark;
    }
    return TelegramMonetConstants.outputFileTelegramXAmoled;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Result of a theme share operation
class ShareThemeResult {
  final bool success;
  final String? error;

  ShareThemeResult({required this.success, this.error});
}

import 'package:flutter/material.dart';
import 'package:random/utils/preferences_helper.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    _currentLanguage = await PreferencesHelper.getLanguage();
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    await PreferencesHelper.saveLanguage(languageCode);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flipz/utils/preferences_helper.dart';
import '../config/app_strings.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  LanguageProvider() {
    _loadLanguage();
  }

  /// Add this method for explicit initialization
  Future<void> init() async {
    await _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    _currentLanguage = await PreferencesHelper.getLanguage();
    AppStrings.setLanguage(_currentLanguage); // Update AppStrings
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    AppStrings.setLanguage(languageCode); // Update AppStrings
    await PreferencesHelper.saveLanguage(languageCode);
    notifyListeners();
  }

  /// Call this in didChangeDependencies to sync AppStrings after hot reload
  void syncAppStrings() {
    AppStrings.setLanguage(_currentLanguage);
  }
}

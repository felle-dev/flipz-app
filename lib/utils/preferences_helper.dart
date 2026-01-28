import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _pinnedGeneratorsKey = 'pinned_generators';
  static const String _pinnedUtilitiesKey = 'pinned_utilities';
  static const String _pinnedGamesKey = 'pinned_games_tools';
  static const String _languageKey = 'app_language';

  // Generators
  static Future<List<String>> getPinnedGenerators() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_pinnedGeneratorsKey) ?? [];
  }

  static Future<void> savePinnedGenerators(List<String> pinnedIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_pinnedGeneratorsKey, pinnedIds);
  }

  // Utilities
  static Future<List<String>> getPinnedUtilities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_pinnedUtilitiesKey) ?? [];
  }

  static Future<void> savePinnedUtilities(List<String> pinnedIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_pinnedUtilitiesKey, pinnedIds);
  }

  // Games
  static Future<List<String>> getPinnedGames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_pinnedGamesKey) ?? [];
  }

  static Future<void> savePinnedGames(List<String> pinnedIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_pinnedGamesKey, pinnedIds);
  }

  // Language
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
}

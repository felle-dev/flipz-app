class AppLanguages {
  static const String english = 'en';
  static const String german = 'de';
  static const String indonesian = 'id';

  static const Map<String, String> languageNames = {
    english: 'English',
    german: 'Deutsch',
    indonesian: 'Indonesia',
  };

  static String getLanguageName(String code) {
    return languageNames[code] ?? languageNames[english]!;
  }
}

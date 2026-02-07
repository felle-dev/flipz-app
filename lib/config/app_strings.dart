import 'app_languages.dart';

/// Localized strings for the Flipz app
/// Supports English (en), German (de), and Indonesian (id)
class AppStrings {
  static String _currentLanguage = AppLanguages.english;

  /// Set the current language for the app
  static void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
  }

  /// Get the current language code
  static String get currentLanguage => _currentLanguage;

  // App Info
  static const String appName = 'Flipz';
  static const String appTitle = 'Flipz';
  static const String appVersion = '1.1.1';

  // Helper method for translation
  static String _t(Map<String, String> translations) {
    return translations[_currentLanguage] ??
        translations[AppLanguages.english]!;
  }

  // Navigation
  static String get navGenerators =>
      _t({'en': 'Generators', 'de': 'Generatoren', 'id': 'Generator'});

  static String get navUtilities =>
      _t({'en': 'Utilities', 'de': 'Dienstprogramme', 'id': 'Utilitas'});

  static String get navGames =>
      _t({'en': 'Games', 'de': 'Spiele', 'id': 'Permainan'});

  // Tooltips
  static String get languageTooltip =>
      _t({'en': 'Language', 'de': 'Sprache', 'id': 'Bahasa'});

  static String get aboutTooltip =>
      _t({'en': 'About', 'de': 'Über', 'id': 'Tentang'});

  // Languages (always show native names)
  static const String languageEnglish = 'English';
  static const String languageGerman = 'Deutsch';
  static const String languageIndonesian = 'Indonesia';

  // About Dialog
  static String get aboutTitle =>
      _t({'en': 'About Flipz', 'de': 'Über Flipz', 'id': 'Tentang Flipz'});

  static String get aboutDescription => _t({
    'en':
        'A comprehensive collection of random generators and utilities for your everyday needs.',
    'de':
        'Eine umfassende Sammlung von Zufallsgeneratoren und Dienstprogrammen für Ihren täglichen Bedarf.',
    'id':
        'Kumpulan lengkap generator acak dan utilitas untuk kebutuhan sehari-hari Anda.',
  });

  static String get aboutDetails => _t({
    'en':
        'Generate numbers, flip coins, roll dice, pick names, and explore many more randomization tools.',
    'de':
        'Generieren Sie Zahlen, werfen Sie Münzen, würfeln Sie, wählen Sie Namen und erkunden Sie viele weitere Zufallswerkzeuge.',
    'id':
        'Hasilkan angka, lempar koin, lempar dadu, pilih nama, dan jelajahi banyak alat acak lainnya.',
  });

  static String get btnClose =>
      _t({'en': 'Close', 'de': 'Schließen', 'id': 'Tutup'});

  static String get btnLicenses =>
      _t({'en': 'Licenses', 'de': 'Lizenzen', 'id': 'Lisensi'});

  // Sections
  static String get pinned =>
      _t({'en': 'Pinned', 'de': 'Angeheftet', 'id': 'Disematkan'});

  static String get allGenerators => _t({
    'en': 'All Generators',
    'de': 'Alle Generatoren',
    'id': 'Semua Generator',
  });

  static String get allUtilities => _t({
    'en': 'All Utilities',
    'de': 'Alle Dienstprogramme',
    'id': 'Semua Utilitas',
  });

  static String get allGames =>
      _t({'en': 'All Tools', 'de': 'Alle Werkzeuge', 'id': 'Semua Alat'});

  static String get pin =>
      _t({'en': 'Pin', 'de': 'Anheften', 'id': 'Sematkan'});

  static String get unpin =>
      _t({'en': 'Unpin', 'de': 'Lösen', 'id': 'Lepas Pin'});

  // Common Actions
  static String get settings =>
      _t({'en': 'Settings', 'de': 'Einstellungen', 'id': 'Pengaturan'});

  static String get clear =>
      _t({'en': 'Clear', 'de': 'Löschen', 'id': 'Hapus'});

  static String get copy => _t({'en': 'Copy', 'de': 'Kopieren', 'id': 'Salin'});

  static String get generate =>
      _t({'en': 'Generate', 'de': 'Generieren', 'id': 'Hasilkan'});

  static String get copiedToClipboard => _t({
    'en': 'Copied to clipboard',
    'de': 'In Zwischenablage kopiert',
    'id': 'Disalin ke clipboard',
  });

  static String get copied =>
      _t({'en': 'Copied', 'de': 'Kopiert', 'id': 'Disalin'});

  static String get copyAll =>
      _t({'en': 'Copy All', 'de': 'Alles kopieren', 'id': 'Salin Semua'});

  static String get cancel =>
      _t({'en': 'Cancel', 'de': 'Abbrechen', 'id': 'Batal'});

  static String get iAgree =>
      _t({'en': 'I Agree', 'de': 'Ich stimme zu', 'id': 'Saya Setuju'});

  static String get options =>
      _t({'en': 'Options', 'de': 'Optionen', 'id': 'Opsi'});

  static String get country =>
      _t({'en': 'Country', 'de': 'Land', 'id': 'Negara'});

  static String get gender =>
      _t({'en': 'Gender', 'de': 'Geschlecht', 'id': 'Jenis Kelamin'});

  static String get random =>
      _t({'en': 'Random', 'de': 'Zufällig', 'id': 'Acak'});

  static String get male =>
      _t({'en': 'Male', 'de': 'Männlich', 'id': 'Laki-laki'});

  static String get female =>
      _t({'en': 'Female', 'de': 'Weiblich', 'id': 'Perempuan'});

  // Generator Items
  static String get generatorPassword =>
      _t({'en': 'Password', 'de': 'Passwort', 'id': 'Kata Sandi'});

  static String get generatorPasswordSubtitle => _t({
    'en': 'Secure passwords',
    'de': 'Sichere Passwörter',
    'id': 'Kata sandi aman',
  });

  static String get generatorEmail =>
      _t({'en': 'Email', 'de': 'E-Mail', 'id': 'Email'});

  static String get generatorEmailSubtitle => _t({
    'en': 'Random emails',
    'de': 'Zufällige E-Mails',
    'id': 'Email acak',
  });

  static String get generatorUsername =>
      _t({'en': 'Username', 'de': 'Benutzername', 'id': 'Nama Pengguna'});

  static String get generatorUsernameSubtitle => _t({
    'en': 'Random usernames',
    'de': 'Zufällige Benutzernamen',
    'id': 'Nama pengguna acak',
  });

  static String get generatorDevice =>
      _t({'en': 'Device Name', 'de': 'Gerätename', 'id': 'Nama Perangkat'});

  static String get generatorDeviceSubtitle => _t({
    'en': 'Random device',
    'de': 'Zufälliges Gerät',
    'id': 'Perangkat acak',
  });

  static String get generatorIdentity =>
      _t({'en': 'Identity', 'de': 'Identität', 'id': 'Identitas'});

  static String get generatorIdentitySubtitle => _t({
    'en': 'Fake identities',
    'de': 'Falsche Identitäten',
    'id': 'Identitas palsu',
  });

  static String get generatorPhone =>
      _t({'en': 'Number', 'de': 'Nummer', 'id': 'Nomor'});

  static String get generatorPhoneSubtitle =>
      _t({'en': 'Fake numbers', 'de': 'Falsche Nummern', 'id': 'Nomor palsu'});

  static String get generatorLoremIpsum =>
      _t({'en': 'Lorem Ipsum', 'de': 'Lorem Ipsum', 'id': 'Lorem Ipsum'});

  static String get generatorLoremIpsumSubtitle => _t({
    'en': 'Placeholder text',
    'de': 'Platzhaltertext',
    'id': 'Teks placeholder',
  });

  // Utility Items
  static String get utilityExifEraser =>
      _t({'en': 'EXIF Eraser', 'de': 'EXIF-Entferner', 'id': 'Penghapus EXIF'});

  static String get utilityExifEraserSubtitle => _t({
    'en': 'Remove metadata',
    'de': 'Metadaten entfernen',
    'id': 'Hapus metadata',
  });

  static String get utilityQuickTiles =>
      _t({'en': 'Quick Tiles', 'de': 'Schnellkacheln', 'id': 'Ubin Cepat'});

  static String get utilityQuickTilesSubtitle => _t({
    'en': 'Manage settings',
    'de': 'Einstellungen verwalten',
    'id': 'Kelola pengaturan',
  });

  static String get utilityUnitConverter => _t({
    'en': 'Unit Converter',
    'de': 'Einheitenumrechner',
    'id': 'Konverter Satuan',
  });

  static String get utilityUnitConverterSubtitle => _t({
    'en': 'Convert units',
    'de': 'Einheiten umrechnen',
    'id': 'Konversi satuan',
  });

  static String get utilityDeviceInfo => _t({
    'en': 'Device Info',
    'de': 'Geräteinformationen',
    'id': 'Info Perangkat',
  });

  static String get utilityDeviceInfoSubtitle => _t({
    'en': 'Phone specs',
    'de': 'Telefonspezifikationen',
    'id': 'Spesifikasi ponsel',
  });

  // Game Items
  static String get gameRandomNumber =>
      _t({'en': 'Random Number', 'de': 'Zufallszahl', 'id': 'Nomor Acak'});

  static String get gameRandomNumberSubtitle => _t({
    'en': 'Generate numbers',
    'de': 'Zahlen generieren',
    'id': 'Hasilkan angka',
  });

  static String get gameDiceRoller =>
      _t({'en': 'Dice Roller', 'de': 'Würfel', 'id': 'Lempar Dadu'});

  static String get gameDiceRollerSubtitle => _t({
    'en': 'Roll virtual dice',
    'de': 'Virtuelle Würfel werfen',
    'id': 'Lempar dadu virtual',
  });

  static String get gameCoinFlip =>
      _t({'en': 'Coin Flip', 'de': 'Münzwurf', 'id': 'Lempar Koin'});

  static String get gameCoinFlipSubtitle => _t({
    'en': 'Flip a virtual coin',
    'de': 'Eine virtuelle Münze werfen',
    'id': 'Lempar koin virtual',
  });

  static String get gameSpinningWheel =>
      _t({'en': 'Spinning Wheel', 'de': 'Glücksrad', 'id': 'Roda Putar'});

  static String get gameSpinningWheelSubtitle => _t({
    'en': 'Spin to decide',
    'de': 'Drehen zum Entscheiden',
    'id': 'Putar untuk memutuskan',
  });

  // Identity Generator
  static String get identityGeneratorTitle => _t({
    'en': 'Random Identity Generator',
    'de': 'Zufallsgenerator für Identitäten',
    'id': 'Generator Identitas Acak',
  });

  static String get legalWarning => _t({
    'en': 'FOR TESTING ONLY - Illegal use is prohibited',
    'de': 'NUR ZUM TESTEN - Illegale Nutzung ist verboten',
    'id': 'HANYA UNTUK PENGUJIAN - Penggunaan ilegal dilarang',
  });

  static String get generateIdentity => _t({
    'en': 'Generate Identity',
    'de': 'Identität generieren',
    'id': 'Hasilkan Identitas',
  });

  static String get generatedIdentity => _t({
    'en': 'Generated Identity',
    'de': 'Generierte Identität',
    'id': 'Identitas yang Dihasilkan',
  });

  static String get allDataCopied => _t({
    'en': 'All data copied!',
    'de': 'Alle Daten kopiert!',
    'id': 'Semua data disalin!',
  });

  // Disclaimer Dialog
  static String get legalDisclaimer => _t({
    'en': 'Legal Disclaimer',
    'de': 'Rechtlicher Hinweis',
    'id': 'Penafian Hukum',
  });

  static String get disclaimerText1 => _t({
    'en':
        'This tool generates FAKE identities for testing and development purposes only.',
    'de':
        'Dieses Tool generiert GEFÄLSCHTE Identitäten nur für Test- und Entwicklungszwecke.',
    'id':
        'Alat ini menghasilkan identitas PALSU hanya untuk tujuan pengujian dan pengembangan.',
  });

  static String get disclaimerWarning => _t({
    'en': '⚠️ WARNING: It is ILLEGAL to use fake identities for:',
    'de':
        '⚠️ WARNUNG: Es ist ILLEGAL, gefälschte Identitäten zu verwenden für:',
    'id': '⚠️ PERINGATAN: ILEGAL menggunakan identitas palsu untuk:',
  });

  static String get disclaimerLegalUses => _t({
    'en': '✅ LEGAL USES ONLY:',
    'de': '✅ NUR RECHTLICHE VERWENDUNG:',
    'id': '✅ HANYA PENGGUNAAN LEGAL:',
  });

  static String get disclaimerAgreement => _t({
    'en':
        'By using this tool, you agree to use it only for legal purposes and take full responsibility for your actions.',
    'de':
        'Durch die Nutzung dieses Tools stimmen Sie zu, es nur für rechtliche Zwecke zu verwenden und die volle Verantwortung für Ihre Handlungen zu übernehmen.',
    'id':
        'Dengan menggunakan alat ini, Anda setuju untuk menggunakannya hanya untuk tujuan legal dan bertanggung jawab penuh atas tindakan Anda.',
  });

  // Countries
  static String get countryUS => _t({
    'en': 'United States',
    'de': 'Vereinigte Staaten',
    'id': 'Amerika Serikat',
  });

  static String get countryGermany =>
      _t({'en': 'Germany', 'de': 'Deutschland', 'id': 'Jerman'});

  static String get countryIndonesia =>
      _t({'en': 'Indonesia', 'de': 'Indonesien', 'id': 'Indonesia'});

  // Username Generator
  static String get usernameGeneratorTitle => _t({
    'en': 'Username Generator',
    'de': 'Benutzername-Generator',
    'id': 'Generator Nama Pengguna',
  });

  static String get generatedUsername => _t({
    'en': 'Generated Username',
    'de': 'Generierter Benutzername',
    'id': 'Nama Pengguna yang Dihasilkan',
  });

  static String get includeAdjective => _t({
    'en': 'Include Adjective',
    'de': 'Adjektiv einschließen',
    'id': 'Sertakan Kata Sifat',
  });

  static String get includeAdjectiveSubtitle => _t({
    'en': 'Add descriptive word',
    'de': 'Beschreibendes Wort hinzufügen',
    'id': 'Tambahkan kata deskriptif',
  });

  static String get includeNumbers => _t({
    'en': 'Include Numbers',
    'de': 'Zahlen einschließen',
    'id': 'Sertakan Angka',
  });

  static String get includeNumbersSubtitle => _t({
    'en': 'Add random numbers',
    'de': 'Zufallszahlen hinzufügen',
    'id': 'Tambahkan angka acak',
  });

  static String get capitalize =>
      _t({'en': 'Capitalize', 'de': 'Großschreiben', 'id': 'Kapitalisasi'});

  static String get capitalizeSubtitle => _t({
    'en': 'Use capital letters',
    'de': 'Großbuchstaben verwenden',
    'id': 'Gunakan huruf kapital',
  });

  static String get separator =>
      _t({'en': 'Separator', 'de': 'Trennzeichen', 'id': 'Pemisah'});

  static String get separatorNone =>
      _t({'en': 'None', 'de': 'Keine', 'id': 'Tidak Ada'});

  static String get recentHistory => _t({
    'en': 'Recent History',
    'de': 'Letzte Verlauf',
    'id': 'Riwayat Terkini',
  });

  // Email Generator
  static String get emailGeneratorTitle => _t({
    'en': 'Email Generator',
    'de': 'E-Mail-Generator',
    'id': 'Generator Email',
  });

  static String get generatedEmailTitle => _t({
    'en': 'Generated Email',
    'de': 'Generierte E-Mail',
    'id': 'Email yang Dihasilkan',
  });

  static String get emailDomain =>
      _t({'en': 'Email Domain', 'de': 'E-Mail-Domäne', 'id': 'Domain Email'});

  // Device/WiFi Generator
  static String get deviceGeneratorTitle => _t({
    'en': 'WiFi Name Generator',
    'de': 'WLAN-Namen-Generator',
    'id': 'Generator Nama WiFi',
  });

  static String get generatedWifiName => _t({
    'en': 'Generated WiFi Name',
    'de': 'Generierter WLAN-Name',
    'id': 'Nama WiFi yang Dihasilkan',
  });

  static String get selectCategory => _t({
    'en': 'Select Category',
    'de': 'Kategorie auswählen',
    'id': 'Pilih Kategori',
  });

  // Password Generator
  static String get passwordGeneratorTitle => _t({
    'en': 'Password Generator',
    'de': 'Passwort-Generator',
    'id': 'Generator Kata Sandi',
  });

  static String get generatedPassword => _t({
    'en': 'Generated Password',
    'de': 'Generiertes Passwort',
    'id': 'Kata Sandi yang Dihasilkan',
  });

  static String get strength =>
      _t({'en': 'Strength', 'de': 'Stärke', 'id': 'Kekuatan'});

  static String get length =>
      _t({'en': 'Length', 'de': 'Länge', 'id': 'Panjang'});

  static String get uppercaseLetters => _t({
    'en': 'Uppercase Letters (A-Z)',
    'de': 'Großbuchstaben (A-Z)',
    'id': 'Huruf Besar (A-Z)',
  });

  static String get uppercaseSubtitle => _t({
    'en': 'Include capital letters',
    'de': 'Großbuchstaben einschließen',
    'id': 'Sertakan huruf kapital',
  });

  static String get lowercaseLetters => _t({
    'en': 'Lowercase Letters (a-z)',
    'de': 'Kleinbuchstaben (a-z)',
    'id': 'Huruf Kecil (a-z)',
  });

  static String get lowercaseSubtitle => _t({
    'en': 'Include lowercase letters',
    'de': 'Kleinbuchstaben einschließen',
    'id': 'Sertakan huruf kecil',
  });

  static String get numbersLabel =>
      _t({'en': 'Numbers (0-9)', 'de': 'Zahlen (0-9)', 'id': 'Angka (0-9)'});

  static String get numbersSubtitle => _t({
    'en': 'Include numeric digits',
    'de': 'Zahlen einschließen',
    'id': 'Sertakan digit angka',
  });

  static String get symbolsLabel => _t({
    'en': 'Symbols (!@#\$...)',
    'de': 'Symbole (!@#\$...)',
    'id': 'Simbol (!@#\$...)',
  });

  static String get symbolsSubtitle => _t({
    'en': 'Include special characters',
    'de': 'Sonderzeichen einschließen',
    'id': 'Sertakan karakter khusus',
  });

  static String get copiedPassword => _t({
    'en': 'Copied password to clipboard',
    'de': 'Passwort in Zwischenablage kopiert',
    'id': 'Kata sandi disalin ke clipboard',
  });

  // Password Strength
  static String get veryStrong =>
      _t({'en': 'Very Strong', 'de': 'Sehr stark', 'id': 'Sangat Kuat'});

  static String get strong => _t({'en': 'Strong', 'de': 'Stark', 'id': 'Kuat'});

  static String get medium =>
      _t({'en': 'Medium', 'de': 'Mittel', 'id': 'Sedang'});

  static String get weak => _t({'en': 'Weak', 'de': 'Schwach', 'id': 'Lemah'});

  // Phone Generator
  static String get phoneGeneratorTitle => _t({
    'en': 'Phone Generator',
    'de': 'Telefon-Generator',
    'id': 'Generator Telepon',
  });

  static String get generatedPhone => _t({
    'en': 'Generated Phone',
    'de': 'Generierte Telefonnummer',
    'id': 'Telepon yang Dihasilkan',
  });

  static String get selectCountry => _t({
    'en': 'Select Country',
    'de': 'Land auswählen',
    'id': 'Pilih Negara',
  });

  static String get withCode =>
      _t({'en': 'With Code', 'de': 'Mit Vorwahl', 'id': 'Dengan Kode'});

  static String get copyWithoutCode => _t({
    'en': 'Copy Without Code',
    'de': 'Ohne Vorwahl kopieren',
    'id': 'Salin Tanpa Kode',
  });

  static String get copiedWithCode => _t({
    'en': 'Copied with country code',
    'de': 'Mit Landesvorwahl kopiert',
    'id': 'Disalin dengan kode negara',
  });

  static String get copiedWithoutCode => _t({
    'en': 'Copied without country code',
    'de': 'Ohne Landesvorwahl kopiert',
    'id': 'Disalin tanpa kode negara',
  });

  // Lorem Ipsum Generator
  static String get loremIpsumGeneratorTitle => _t({
    'en': 'Lorem Ipsum Generator',
    'de': 'Lorem-Ipsum-Generator',
    'id': 'Generator Lorem Ipsum',
  });

  static String get generatedText => _t({
    'en': 'Generated Text',
    'de': 'Generierter Text',
    'id': 'Teks yang Dihasilkan',
  });

  static String get type => _t({'en': 'Type', 'de': 'Typ', 'id': 'Tipe'});

  static String get words => _t({'en': 'Words', 'de': 'Wörter', 'id': 'Kata'});

  static String get sentences =>
      _t({'en': 'Sentences', 'de': 'Sätze', 'id': 'Kalimat'});

  static String get paragraphs =>
      _t({'en': 'Paragraphs', 'de': 'Absätze', 'id': 'Paragraf'});

  static String get count =>
      _t({'en': 'Count', 'de': 'Anzahl', 'id': 'Jumlah'});

  static String get startWithLorem => _t({
    'en': 'Start with "Lorem ipsum"',
    'de': 'Mit "Lorem ipsum" beginnen',
    'id': 'Mulai dengan "Lorem ipsum"',
  });

  static String get startWithLoremSubtitle => _t({
    'en': 'Begin with classic phrase',
    'de': 'Mit klassischer Phrase beginnen',
    'id': 'Mulai dengan frasa klasik',
  });

  // Unit Converter
  static String get unitConverterTitle => _t({
    'en': 'Unit Converter',
    'de': 'Einheitenumrechner',
    'id': 'Konverter Satuan',
  });

  static String get category =>
      _t({'en': 'Category', 'de': 'Kategorie', 'id': 'Kategori'});

  static String get from => _t({'en': 'From', 'de': 'Von', 'id': 'Dari'});

  static String get to => _t({'en': 'To', 'de': 'Zu', 'id': 'Ke'});

  static String get unit => _t({'en': 'Unit', 'de': 'Einheit', 'id': 'Satuan'});

  static String get enterValue => _t({
    'en': 'Enter value to convert',
    'de': 'Wert zum Umrechnen eingeben',
    'id': 'Masukkan nilai untuk dikonversi',
  });

  static String get result =>
      _t({'en': 'Result', 'de': 'Ergebnis', 'id': 'Hasil'});

  static String get invalidInput => _t({
    'en': 'Invalid input',
    'de': 'Ungültige Eingabe',
    'id': 'Input tidak valid',
  });

  static String get resultCopied => _t({
    'en': 'Result copied!',
    'de': 'Ergebnis kopiert!',
    'id': 'Hasil disalin!',
  });

  // Note: EXIF and Device Info strings would continue here
  // Keeping them as constants for brevity since they're technical terms
  // that often don't need translation

  // EXIF Eraser
  static String get exifEraserTitle => 'EXIF Eraser';
  static String get exifEraserSelectImage =>
      _t({'en': 'Select Image', 'de': 'Bild auswählen', 'id': 'Pilih Gambar'});
  static String get exifEraserChooseGallery => _t({
    'en': 'Choose from Gallery',
    'de': 'Aus Galerie wählen',
    'id': 'Pilih dari Galeri',
  });
  static String get exifEraserTakePhoto =>
      _t({'en': 'Take a Photo', 'de': 'Foto aufnehmen', 'id': 'Ambil Foto'});
  static String get exifEraserRemoveExif => _t({
    'en': 'Remove EXIF Data',
    'de': 'EXIF-Daten entfernen',
    'id': 'Hapus Data EXIF',
  });
  static String get exifEraserProcessing => _t({
    'en': 'Processing...',
    'de': 'Verarbeitung...',
    'id': 'Memproses...',
  });
  static String get exifEraserSelectNew => _t({
    'en': 'Select New Image',
    'de': 'Neues Bild auswählen',
    'id': 'Pilih Gambar Baru',
  });
  static String get exifEraserActions =>
      _t({'en': 'Actions', 'de': 'Aktionen', 'id': 'Tindakan'});
  static String get exifEraserSelectedImage => _t({
    'en': 'Selected Image',
    'de': 'Ausgewähltes Bild',
    'id': 'Gambar yang Dipilih',
  });
  static String get exifEraserProcessedImage => _t({
    'en': 'Processed Image',
    'de': 'Verarbeitetes Bild',
    'id': 'Gambar yang Diproses',
  });
  static String get exifEraserDownload =>
      _t({'en': 'Download', 'de': 'Herunterladen', 'id': 'Unduh'});
  static String get exifEraserSave =>
      _t({'en': 'Save', 'de': 'Speichern', 'id': 'Simpan'});
  static String get exifEraserShare =>
      _t({'en': 'Share', 'de': 'Teilen', 'id': 'Bagikan'});
  static String get exifEraserDataDetected => _t({
    'en': 'EXIF Data Detected',
    'de': 'EXIF-Daten erkannt',
    'id': 'Data EXIF Terdeteksi',
  });
  static String get exifEraserFields =>
      _t({'en': 'fields', 'de': 'Felder', 'id': 'bidang'});
  static String get exifEraserContainsMetadata => _t({
    'en': 'This image contains EXIF metadata',
    'de': 'Dieses Bild enthält EXIF-Metadaten',
    'id': 'Gambar ini berisi metadata EXIF',
  });
  static String get exifEraserMetadataInfo => _t({
    'en':
        'EXIF data may include location, camera model, date, and other metadata.',
    'de':
        'EXIF-Daten können Standort, Kameramodell, Datum und andere Metadaten enthalten.',
    'id':
        'Data EXIF mungkin termasuk lokasi, model kamera, tanggal, dan metadata lainnya.',
  });
  static String get exifEraserDetails =>
      _t({'en': 'EXIF Details:', 'de': 'EXIF-Details:', 'id': 'Detail EXIF:'});
  static String get exifEraserDataRemoved => _t({
    'en': 'EXIF Data Removed',
    'de': 'EXIF-Daten entfernt',
    'id': 'Data EXIF Dihapus',
  });
  static String get exifEraserProcessedSuccess => _t({
    'en':
        'Your image has been processed and all EXIF metadata has been removed. You can now save or share it safely.',
    'de':
        'Ihr Bild wurde verarbeitet und alle EXIF-Metadaten wurden entfernt. Sie können es jetzt sicher speichern oder teilen.',
    'id':
        'Gambar Anda telah diproses dan semua metadata EXIF telah dihapus. Anda sekarang dapat menyimpan atau membagikannya dengan aman.',
  });
  static String get exifEraserAboutTitle => _t({
    'en': 'About EXIF Data',
    'de': 'Über EXIF-Daten',
    'id': 'Tentang Data EXIF',
  });
  static String get exifEraserAboutInfo => _t({
    'en':
        'EXIF (Exchangeable Image File Format) data is metadata embedded in photos. It can include GPS location, camera settings, date and time, and more. Removing EXIF data helps protect your privacy when sharing images online.',
    'de':
        'EXIF-Daten (Exchangeable Image File Format) sind in Fotos eingebettete Metadaten. Sie können GPS-Position, Kameraeinstellungen, Datum und Uhrzeit und mehr enthalten. Das Entfernen von EXIF-Daten schützt Ihre Privatsphäre beim Teilen von Bildern online.',
    'id':
        'Data EXIF (Exchangeable Image File Format) adalah metadata yang tertanam dalam foto. Ini dapat mencakup lokasi GPS, pengaturan kamera, tanggal dan waktu, dan lainnya. Menghapus data EXIF membantu melindungi privasi Anda saat berbagi gambar online.',
  });
  static String get exifEraserSuccess => _t({
    'en': 'EXIF data removed successfully!',
    'de': 'EXIF-Daten erfolgreich entfernt!',
    'id': 'Data EXIF berhasil dihapus!',
  });
  static String get exifEraserErrorPicking => _t({
    'en': 'Error picking image: ',
    'de': 'Fehler beim Auswählen des Bildes: ',
    'id': 'Kesalahan memilih gambar: ',
  });
  static String get exifEraserErrorProcessing => _t({
    'en': 'Error processing image: ',
    'de': 'Fehler beim Verarbeiten des Bildes: ',
    'id': 'Kesalahan memproses gambar: ',
  });
  static String get exifEraserErrorSaving => _t({
    'en': 'Error saving image: ',
    'de': 'Fehler beim Speichern des Bildes: ',
    'id': 'Kesalahan menyimpan gambar: ',
  });
  static String get exifEraserErrorSharing => _t({
    'en': 'Error sharing image: ',
    'de': 'Fehler beim Teilen des Bildes: ',
    'id': 'Kesalahan membagikan gambar: ',
  });
  static String get exifEraserNoImage => _t({
    'en': 'No processed image available',
    'de': 'Kein verarbeitetes Bild verfügbar',
    'id': 'Tidak ada gambar yang diproses tersedia',
  });
  static String get exifEraserPermissionDenied => _t({
    'en': 'Permission denied. Cannot save to gallery.',
    'de': 'Berechtigung verweigert. Kann nicht in Galerie speichern.',
    'id': 'Izin ditolak. Tidak dapat menyimpan ke galeri.',
  });
  static String get exifEraserNoDirectory => _t({
    'en': 'No directory selected',
    'de': 'Kein Verzeichnis ausgewählt',
    'id': 'Tidak ada direktori yang dipilih',
  });
  static String get exifEraserImageDownloaded => _t({
    'en': 'Image downloaded successfully!',
    'de': 'Bild erfolgreich heruntergeladen!',
    'id': 'Gambar berhasil diunduh!',
  });
  static String get exifEraserImageSavedRandom => _t({
    'en': 'Image saved to "Pictures/Random/"',
    'de': 'Bild gespeichert unter "Bilder/Random/"',
    'id': 'Gambar disimpan di "Pictures/Random/"',
  });
  static String get exifEraserImageSavedGallery => _t({
    'en': 'Image saved to gallery!',
    'de': 'Bild in Galerie gespeichert!',
    'id': 'Gambar disimpan di galeri!',
  });
  static String get exifEraserImageSavedTo => _t({
    'en': 'Image saved to: ',
    'de': 'Bild gespeichert unter: ',
    'id': 'Gambar disimpan di: ',
  });
  static String get exifEraserShareText => _t({
    'en': 'Image with EXIF data removed',
    'de': 'Bild mit entfernten EXIF-Daten',
    'id': 'Gambar dengan data EXIF dihapus',
  });
  static String get exifEraserUseDownload => _t({
    'en': 'Use save/download for web',
    'de': 'Speichern/Herunterladen für Web verwenden',
    'id': 'Gunakan simpan/unduh untuk web',
  });
  static String get exifEraserErrorParse => _t({
    'en': 'Could not parse EXIF data',
    'de': 'EXIF-Daten konnten nicht analysiert werden',
    'id': 'Tidak dapat mengurai data EXIF',
  });

  // Device Info - keeping technical terms mostly in English
  static String get deviceInfoTitle => _t({
    'en': 'Device Info',
    'de': 'Geräteinformationen',
    'id': 'Info Perangkat',
  });
  static String get deviceInfoBatteryHealth => _t({
    'en': 'Battery Health',
    'de': 'Batteriezustand',
    'id': 'Kesehatan Baterai',
  });
  static String get deviceInfoDeviceInformation => _t({
    'en': 'Device Information',
    'de': 'Geräteinformationen',
    'id': 'Informasi Perangkat',
  });
  static String get deviceInfoCopyAll =>
      _t({'en': 'Copy All', 'de': 'Alles kopieren', 'id': 'Salin Semua'});
  static String get deviceInfoRefresh => _t({
    'en': 'Refresh Info',
    'de': 'Informationen aktualisieren',
    'id': 'Perbarui Info',
  });
  static String get deviceInfoCopied => _t({
    'en': 'Device info copied!',
    'de': 'Geräteinformationen kopiert!',
    'id': 'Info perangkat disalin!',
  });
  static String get deviceInfoBatteryLevel =>
      _t({'en': 'Battery Level', 'de': 'Batteriestand', 'id': 'Level Baterai'});
  static String get deviceInfoBatteryState => _t({
    'en': 'Battery State',
    'de': 'Batteriestatus',
    'id': 'Status Baterai',
  });
  static String get deviceInfoHealthStatus => _t({
    'en': 'Health Status',
    'de': 'Gesundheitsstatus',
    'id': 'Status Kesehatan',
  });
  static String get deviceInfoChargingCycles => _t({
    'en': 'Charging Cycles',
    'de': 'Ladezyklen',
    'id': 'Siklus Pengisian',
  });
  static String get deviceInfoBatteryCharging =>
      _t({'en': 'Charging', 'de': 'Laden', 'id': 'Mengisi'});
  static String get deviceInfoBatteryFull =>
      _t({'en': 'Full', 'de': 'Voll', 'id': 'Penuh'});
  static String get deviceInfoBatteryDischarging =>
      _t({'en': 'Discharging', 'de': 'Entladen', 'id': 'Menguras'});
  static String get deviceInfoBatteryUnknown =>
      _t({'en': 'Unknown', 'de': 'Unbekannt', 'id': 'Tidak Diketahui'});
  static String get deviceInfoHealthGood =>
      _t({'en': 'Good', 'de': 'Gut', 'id': 'Baik'});
  static String get deviceInfoHealthFair =>
      _t({'en': 'Fair', 'de': 'Mittel', 'id': 'Cukup'});
  static String get deviceInfoHealthLow =>
      _t({'en': 'Low', 'de': 'Niedrig', 'id': 'Rendah'});
  static String get deviceInfoHealthCritical =>
      _t({'en': 'Critical', 'de': 'Kritisch', 'id': 'Kritis'});
  static String get deviceInfoBatteryNotAvailable => _t({
    'en': 'Battery information is not available on this platform.',
    'de': 'Batterieinformationen sind auf dieser Plattform nicht verfügbar.',
    'id': 'Informasi baterai tidak tersedia di platform ini.',
  });
  static String get deviceInfoErrorPrefix => _t({
    'en': 'Failed to get device info: ',
    'de': 'Fehler beim Abrufen der Geräteinformationen: ',
    'id': 'Gagal mendapatkan info perangkat: ',
  });
  static String get deviceInfoBatteryError => _t({
    'en': 'Battery info not available on this platform',
    'de': 'Batterieinformationen auf dieser Plattform nicht verfügbar',
    'id': 'Info baterai tidak tersedia di platform ini',
  });

  // Technical device fields - keeping in English as they're technical terms
  static const String deviceInfoBrand = 'Brand';
  static const String deviceInfoModel = 'Model';
  static const String deviceInfoDevice = 'Device';
  static const String deviceInfoManufacturer = 'Manufacturer';
  static const String deviceInfoProduct = 'Product';
  static const String deviceInfoAndroidVersion = 'Android Version';
  static const String deviceInfoSdkVersion = 'SDK Version';
  static const String deviceInfoSecurityPatch = 'Security Patch';
  static const String deviceInfoBoard = 'Board';
  static const String deviceInfoHardware = 'Hardware';
  static const String deviceInfoSupportedAbis = 'Supported ABIs';
  static const String deviceInfoIsPhysicalDevice = 'Is Physical Device';
  static const String deviceInfoName = 'Name';
  static const String deviceInfoSystemName = 'System Name';
  static const String deviceInfoSystemVersion = 'System Version';
  static const String deviceInfoLocalModel = 'Local Model';
  static const String deviceInfoIdentifier = 'Identifier';
  static const String deviceInfoComputerName = 'Computer Name';
  static const String deviceInfoNumberOfCores = 'Number of Cores';
  static const String deviceInfoSystemMemory = 'System Memory (GB)';
  static const String deviceInfoProductName = 'Product Name';
  static const String deviceInfoDisplayVersion = 'Display Version';
  static const String deviceInfoPlatformId = 'Platform ID';
  static const String deviceInfoMajorVersion = 'Major Version';
  static const String deviceInfoMinorVersion = 'Minor Version';
  static const String deviceInfoBuildNumber = 'Build Number';
  static const String deviceInfoVersion = 'Version';
  static const String deviceInfoId = 'ID';
  static const String deviceInfoIdLike = 'ID Like';
  static const String deviceInfoVersionCodename = 'Version Codename';
  static const String deviceInfoVersionId = 'Version ID';
  static const String deviceInfoPrettyName = 'Pretty Name';
  static const String deviceInfoBuildId = 'Build ID';
  static const String deviceInfoVariant = 'Variant';
  static const String deviceInfoVariantId = 'Variant ID';
  static const String deviceInfoMachineId = 'Machine ID';
  static const String deviceInfoHostName = 'Host Name';
  static const String deviceInfoKernelVersion = 'Kernel Version';
  static const String deviceInfoOsRelease = 'OS Release';
  static const String deviceInfoPatchVersion = 'Patch Version';
  static const String deviceInfoSystemGuid = 'System GUID';
}

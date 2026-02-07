/// Configuration constants for EXIF Eraser feature
class ExifConstants {
  // File naming
  static const String filePrefix = 'exif_erased';
  static const String fileExtension = '.jpg';

  // Image encoding
  static const int jpegQuality = 95;

  // Android album name
  static const String androidAlbumName = 'Random';

  // Supported image formats
  static const List<String> supportedFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];

  // EXIF data categories
  static const String exifCategoryImage = 'Image';
  static const String exifCategoryExif = 'EXIF';
  static const String exifCategoryGps = 'GPS';
  static const String exifCategoryThumbnail = 'Thumbnail';
  static const String exifCategoryError = 'Error';

  // File name generator
  static String generateFileName() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$filePrefix\_$timestamp$fileExtension';
  }

  // Download file name for web
  static String generateDownloadName() {
    return generateFileName();
  }

  // Temporary file path generator
  static String generateTempPath(String tempDirPath) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$tempDirPath/$filePrefix\_$timestamp$fileExtension';
  }
}

import 'dart:io' show File, Platform;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:gal/gal.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import '../../config/app_strings.dart';
import '../../config/exif_constants.dart';

class ExifEraserHelper {
  static Future<String> saveImage({
    required Uint8List? webProcessedBytes,
    required File? processedImage,
  }) async {
    if (kIsWeb) {
      if (webProcessedBytes == null) {
        throw Exception(AppStrings.exifEraserNoImage);
      }
      final blob = html.Blob([webProcessedBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      // ignore: unused_local_variable
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', ExifConstants.generateDownloadName())
        ..click();
      html.Url.revokeObjectUrl(url);
      return AppStrings.exifEraserImageDownloaded;
    }

    if (processedImage == null) {
      throw Exception(AppStrings.exifEraserNoImage);
    }

    final bytes = await processedImage.readAsBytes();
    if (Platform.isAndroid || Platform.isIOS) {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          throw Exception(AppStrings.exifEraserPermissionDenied);
        }
      }

      // Save to "Random" album only on Android
      if (Platform.isAndroid) {
        await Gal.putImageBytes(
          bytes,
          album: ExifConstants.androidAlbumName,
          name: ExifConstants.generateFileName().replaceAll(
            ExifConstants.fileExtension,
            '',
          ),
        );
        return AppStrings.exifEraserImageSavedRandom;
      } else {
        // iOS: save without album parameter
        await Gal.putImageBytes(
          bytes,
          name: ExifConstants.generateFileName().replaceAll(
            ExifConstants.fileExtension,
            '',
          ),
        );
        return AppStrings.exifEraserImageSavedGallery;
      }
    } else {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        throw Exception(AppStrings.exifEraserNoDirectory);
      }

      final fileName = ExifConstants.generateFileName();
      final savePath = '$selectedDirectory/$fileName';
      final saveFile = File(savePath);
      await saveFile.writeAsBytes(bytes);

      // Open file after saving (desktop platforms)
      await OpenFile.open(savePath);
      return '${AppStrings.exifEraserImageSavedTo}$savePath';
    }
  }

  static Future<void> shareImage({
    required Uint8List? webImageBytes,
    required File? processedImage,
  }) async {
    if (kIsWeb && webImageBytes == null) {
      throw Exception(AppStrings.exifEraserNoImage);
    }
    if (!kIsWeb && processedImage == null) {
      throw Exception(AppStrings.exifEraserNoImage);
    }

    if (kIsWeb) {
      // Web download instead of share
      throw Exception(AppStrings.exifEraserUseDownload);
    } else {
      await Share.shareXFiles([
        XFile(processedImage!.path),
      ], text: AppStrings.exifEraserShareText);
    }
  }
}

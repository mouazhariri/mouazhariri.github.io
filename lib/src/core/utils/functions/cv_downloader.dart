import 'cv_downloader_stub.dart'
    if (dart.library.js_interop) 'cv_downloader_web.dart' as impl;

/// Downloads the bundled CV.
///
/// On web the browser gets a real file download (Blob);
/// elsewhere it falls back to opening the bundled asset.
abstract class CvDownloader {
  const CvDownloader._();

  static const String fileName = 'Mouaz-Hariri-CV.pdf';

  static Future<String> download() => impl.downloadCv();
}
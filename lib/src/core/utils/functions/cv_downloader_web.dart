import 'dart:js_interop';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:web/web.dart' as web;

/// Web implementation — creates a Blob from the bundled PDF and triggers a
/// browser download with the real file name (no server needed).
Future<String> downloadCv() async {
  const assetPath = 'assets/files/Mouaz-Hariri-CV.pdf';
  final ByteData raw = await rootBundle.load(assetPath);
  final bytes = raw.buffer.asUint8List(raw.offsetInBytes, raw.lengthInBytes);

  final blob = web.Blob(
    <JSAny>[bytes.toJS].toJS,
    web.BlobPropertyBag(type: 'application/pdf'),
  );
  final url = web.URL.createObjectURL(blob);

  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = 'Mouaz-Hariri-CV.pdf';
  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
  return 'Mouaz-Hariri-CV.pdf';
}
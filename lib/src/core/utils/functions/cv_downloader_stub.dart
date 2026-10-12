import 'package:url_launcher/url_launcher.dart';

/// Non-web fallback — opens the bundled asset directly.
Future<String> downloadCv() async {
  final ok = await launchUrl(
    Uri.parse('assets/assets/files/Mouaz-Hariri-CV.pdf'),
    webOnlyWindowName: '_blank',
  );
  return ok ? 'Mouaz-Hariri-CV.pdf' : '';
}
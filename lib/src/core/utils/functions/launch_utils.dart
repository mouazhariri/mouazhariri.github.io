import 'package:url_launcher/url_launcher.dart';

import '../../../logger/dev_logger.dart';

/// Central URL launching helpers — never inline `launchUrl` in widgets.
abstract class LaunchUtils {
  const LaunchUtils._();

  static Future<void> open(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
    if (!ok) Dev.logError('Could not open url: $url');
  }

  /// Opens a `mailto:` with a prefilled subject/body.
  static Future<void> sendEmail({
    required String to,
    String subject = '',
    String body = '',
  }) async {
    final params = <String, String>{
      if (subject.isNotEmpty) 'subject': subject,
      if (body.isNotEmpty) 'body': body,
    };
    final query = params.entries
        .map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
        .join('&');
    await open('mailto:$to${query.isEmpty ? '' : '?$query'}');
  }
}
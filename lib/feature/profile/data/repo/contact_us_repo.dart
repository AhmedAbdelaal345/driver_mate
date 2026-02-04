import 'package:url_launcher/url_launcher.dart';

abstract class EmailRepository {
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  });
}

class EmailRepositoryImpl implements EmailRepository {
  @override
  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (!await launchUrl(uri)) {
      throw Exception('Unable to open email app');
    }
  }
}

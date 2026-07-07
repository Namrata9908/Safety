import 'package:url_launcher/url_launcher.dart';

class SmsService {
  static Future<void> sendSOS(
    List<String> phones,
    double latitude,
    double longitude,
  ) async {
    final String recipients = phones.join(",");

    final String message =
        "🚨 EMERGENCY ALERT 🚨\n\n"
        "I need help!\n\n"
        "My Live Location:\n"
        "https://maps.google.com/?q=$latitude,$longitude\n\n"
        "Please reach me immediately.";

    final Uri smsUri = Uri(
      scheme: "sms",
      path: recipients,
      queryParameters: {"body": message},
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw "Could not open SMS app";
    }
  }
}

import 'package:url_launcher/url_launcher.dart';

class MapService {
  static Future<void> openMap(double latitude, double longitude) async {
    final Uri mapUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not open Google Maps";
    }
  }

  static Future<void> openNearbyPlaces(String place) async {
    final Uri uri = Uri.parse("https://www.google.com/maps/search/$place");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not open Google Maps";
    }
  }
}

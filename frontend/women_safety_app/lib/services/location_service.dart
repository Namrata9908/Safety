import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    // Check location service
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        "Location service is OFF. Please enable GPS and try again.",
      );
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    // Request permission
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // User denied permission
    if (permission == LocationPermission.denied) {
      throw Exception(
        "Location permission is required for SOS. Please allow location access.",
      );
    }

    // User selected Don't ask again
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Location permission permanently denied. Please enable it from App Settings.",
      );
    }

    // Get current location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

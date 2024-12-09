import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getUserLocation() async {
    try {
      final hasPermission = await _location.requestPermission();
      if (hasPermission == PermissionStatus.granted) {
        return await _location.getLocation();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user location: $e");
      }
    }
    return null;
  }
}
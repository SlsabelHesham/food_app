import 'dart:math';

class Helper {
  static calculateDistance(
    double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371;
    final double dLat = degToRad(lat2 - lat1);
    final double dLon = degToRad(lon2 - lon1);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(lat1)) *
            cos(degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static degToRad(double deg) {
    return deg * (pi / 180);
  }
}

abstract class DetailScreenEvent {}

class FetchUserLocationEvent extends DetailScreenEvent {}

class FetchDistanceEvent extends DetailScreenEvent {
  final double userLat;
  final double userLon;
  final double restaurantLat;
  final double restaurantLon;

  FetchDistanceEvent({
    required this.userLat,
    required this.userLon,
    required this.restaurantLat,
    required this.restaurantLon,
  });
}
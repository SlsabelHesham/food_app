import 'package:location/location.dart';

abstract class RestaurantRepository {
  Future<List<Map<String, dynamic>>> getAllRestaurants();

  List<Map<String, dynamic>> sortByDistance(
      List<Map<String, dynamic>> restaurants, LocationData userLocation);

  List<Map<String, dynamic>> sortByRating(
      List<Map<String, dynamic>> restaurants);

  List<Map<String, dynamic>> getPopularMenu(
      List<Map<String, dynamic>> restaurants);

  Future<List<Object?>> getFilteredRestaurants(String mealName);
}
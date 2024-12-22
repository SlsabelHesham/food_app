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

  Future<(String, List<Map<String, dynamic>>)> searchAndFilter(
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  );

  Future<(String, List<Map<String, dynamic>>)> filterRestaurants(
    List<Map<String, dynamic>?> restaurants,
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  );

  List<Map<String, dynamic>> filterByMealName(
    List<Map<String, dynamic>?> restaurants,
    String mealName,
  );

  bool isMealNameMatched(String? mealName, String searchName);
  String determineType(String selectedType);
  List<Map<String, dynamic>> filterByType(
    List<Map<String, dynamic>> meals,
    String selectedType,
  );
  Future<List<Map<String, dynamic>>> filterByLocation(
    List<Map<String, dynamic>> meals,
    String selectedLocation,
  );
  bool isWithinSelectedDistance(double distance, String selectedLocation);
  List<Map<String, dynamic>> filterByFoods(
    List<Map<String, dynamic>> meals,
    List<String> selectedFoods,
  );
}

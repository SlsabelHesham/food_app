import 'package:food_app/domain/models/restaurant.dart';
import 'package:location/location.dart';

import '../../domain/models/filtered_meal.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getAllRestaurants();

  List<Restaurant> sortByDistance(
      List<Restaurant> restaurants, LocationData userLocation);

  List<Restaurant> sortByRating(List<Restaurant> meals);

  List<FilteredMeal> getPopularMenu(List<Restaurant> restaurants);

  Future<List<Object?>> getFilteredRestaurants(String mealName);

  Future<(String, List<FilteredMeal?>)> searchAndFilter(
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  );

  Future<(String, List<FilteredMeal?>)> filterRestaurants(
    List<Restaurant> restaurants,
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  );
  List<FilteredMeal> filterByMealName(
      List<Restaurant> restaurants, String mealName);

  bool isMealNameMatched(String? mealName, String searchName);
  String determineType(String selectedType);
  List<FilteredMeal?> filterByType(
      List<FilteredMeal?> meals, String selectedType);
  Future<List<FilteredMeal?>> filterByLocation(
      List<FilteredMeal?> meals, String selectedLocation);
  bool isWithinSelectedDistance(double distance, String selectedLocation);

  List<FilteredMeal?> filterByFoods(
      List<FilteredMeal?> meals, List<String> selectedFoods);
}

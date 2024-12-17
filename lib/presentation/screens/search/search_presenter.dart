import 'package:food_app/core/utils/helper.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource.dart';
import 'package:food_app/services/location_service.dart';

class RestaurantPresenter {
  final RestaurantDataSource dataSource;

  RestaurantPresenter(this.dataSource);

  Future<(String, List<Map<String, dynamic>>)> searchAndFilter(
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  ) async {
    final restaurants = await dataSource.fetchRestaurantsByMealName(mealName);

    return _filterRestaurants(
      restaurants,
      mealName,
      selectedType,
      selectedLocation,
      selectedFoods,
    );
  }

  Future<(String, List<Map<String, dynamic>>)> _filterRestaurants(
    List<Map<String, dynamic>?> restaurants,
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  ) async {
    var filteredMeals = _filterByMealName(restaurants, mealName);
    var type = _determineType(selectedType);

    if (selectedType.isNotEmpty) {
      filteredMeals = _filterByType(filteredMeals, selectedType);
    }

    if (selectedLocation.isNotEmpty) {
      filteredMeals = await _filterByLocation(filteredMeals, selectedLocation);
    }

    if (selectedFoods.isNotEmpty) {
      filteredMeals = _filterByFoods(filteredMeals, selectedFoods);
    }

    return (type, filteredMeals);
  }

  List<Map<String, dynamic>> _filterByMealName(
    List<Map<String, dynamic>?> restaurants,
    String mealName,
  ) {
    if (mealName.isEmpty) return [];

    final filteredMeals = <Map<String, dynamic>>[];

    for (final restaurant in restaurants) {
      for (final meal in restaurant?['meals'] ?? []) {
        if (_isMealNameMatched(meal['name'], mealName)) {
          filteredMeals.add({
            ...meal,
            'restaurant_name': restaurant?['name'],
            'restaurant_time': restaurant?['time'],
            'restaurant_image': restaurant?['image'],
            'location': restaurant?['location'],
            'meal_name': meal['name'],
            'meal_image': meal['image'],
            'meal_price': meal['price'],
          });
        }
      }
    }

    return filteredMeals;
  }

  bool _isMealNameMatched(String? mealName, String searchName) {
    return mealName
            ?.toString()
            .toLowerCase()
            .trim()
            .contains(searchName.toLowerCase().trim()) ??
        false;
  }

  String _determineType(String selectedType) {
    if (selectedType.isEmpty) return "Meals";
    return selectedType == "Restaurant" ? "Restaurants" : "Meals";
  }

  List<Map<String, dynamic>> _filterByType(
    List<Map<String, dynamic>> meals,
    String selectedType,
  ) {
    return meals.where((meal) {
      return selectedType == "Restaurant"
          ? meal['restaurant_name'] != null
          : meal['meal_name'] != null;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _filterByLocation(
    List<Map<String, dynamic>> meals,
    String selectedLocation,
  ) async {
    final locationService = LocationService();
    final userLocation = await locationService.getUserLocation();

    return meals.where((meal) {
      final restaurantLocation = meal['location'] as Map<String, dynamic>?;
      if (restaurantLocation != null) {
        final distance = Helper.calculateDistance(
          userLocation?.latitude ?? 0.0,
          userLocation?.longitude ?? 0.0,
          restaurantLocation['latitude'] ?? 0.0,
          restaurantLocation['longitude'] ?? 0.0,
        );

        return _isWithinSelectedDistance(distance, selectedLocation);
      }
      return false;
    }).toList();
  }

  bool _isWithinSelectedDistance(double distance, String selectedLocation) {
    if (selectedLocation == "<10 Km") {
      return distance < 10.0;
    } else if (selectedLocation == ">10 Km") {
      return distance > 10.0;
    } else if (selectedLocation == "1 Km") {
      return distance == 1.0;
    }
    return false;
  }

  List<Map<String, dynamic>> _filterByFoods(
    List<Map<String, dynamic>> meals,
    List<String> selectedFoods,
  ) {
    return meals.where((meal) {
      final mealType = meal['type']?.toString().toLowerCase();
      return mealType != null && selectedFoods.contains(mealType);
    }).toList();
  }
}

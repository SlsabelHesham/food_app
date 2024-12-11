import 'package:food_app/core/utils/helper.dart';
import 'package:food_app/data/datasources/restaurant_datasource.dart';
import 'package:food_app/services/location_service.dart';
import 'package:location/location.dart';

class RestaurantPresenter {
  final RestaurantDataSource dataSource;

  RestaurantPresenter(this.dataSource);

  Future<(String, List<Map<String, dynamic>>)> searchAndFilter(
      String mealName,
      String selectedType,
      String selectedLocation,
      List<String> selectedFoods) async {
    final restaurants = await dataSource.fetchRestaurantsByMealName(mealName);

    return _filterRestaurants(
        restaurants, mealName, selectedType, selectedLocation, selectedFoods);
  }

  Future<(String, List<Map<String, dynamic>>)> _filterRestaurants(
      List<Map<String, dynamic>?> restaurants,
      String mealName,
      String selectedType,
      String selectedLocation,
      List<String> selectedFoods) async {
    var filteredMeals = <Map<String, dynamic>>[];
    var type = "Meals";
    for (final restaurant in restaurants) {
      if (mealName.isNotEmpty) {
        for (final meal in restaurant?['meals']) {
          if (meal['name'] == mealName) {
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
    }

    if (selectedType.isNotEmpty) {
      if (selectedType == "Restaurant") {
        type = "Restaurants";
      } else {
        type = "Meals";
      }
      filteredMeals = filteredMeals
          .where((meal) => selectedType == "Restaurant"
              ? meal['restaurant_name'] != null
              : meal['meal_name'] != null)
          .toList();
    }

    if (selectedLocation.isNotEmpty) {
      type = "Restaurants";
      
    }
    if (selectedLocation.isNotEmpty) {
      LocationService locationService = LocationService();
      LocationData? userLocation = await locationService.getUserLocation();
        filteredMeals = filteredMeals.where((meal) {
          final restaurantLocation = meal['location'] as Map<String, dynamic>?;
          if (restaurantLocation != null) {
            final restaurantLat = restaurantLocation['latitude'] ?? 0.0;
            final restaurantLng = restaurantLocation['longitude'] ?? 0.0;
            final distance = Helper.calculateDistance(userLocation?.latitude ?? 0.0,
                userLocation?.longitude ?? 0.0, restaurantLat, restaurantLng);
            if (selectedLocation == "<10 Km") {
              return distance < 10.0;
            } else if (selectedLocation == ">10 Km") {
              return distance > 10.0;
            } else if (selectedLocation == "1 Km") {
              return distance == 1.0;
            }
          }
          return true;
        }).toList();
      }


    if (selectedFoods.isNotEmpty) {
      filteredMeals = filteredMeals.where((meal) {
        final mealType = meal['type']?.toString().toLowerCase();
        return mealType != null && selectedFoods.contains(mealType);
      }).toList();
    }
    return (type, filteredMeals);
  }
}

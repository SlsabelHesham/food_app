import 'package:food_app/core/utils/helper.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource.dart';
import 'package:food_app/services/location_service.dart';
import 'package:location/location.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDataSource dataSource;

  RestaurantRepositoryImpl(this.dataSource);

  @override
  Future<List<Map<String, dynamic>>> getAllRestaurants() async {
    return await dataSource.fetchRestaurants();
  }

  @override
  List<Map<String, dynamic>> sortByDistance(
      List<Map<String, dynamic>> restaurants, LocationData userLocation) {
    return List.from(restaurants)
      ..sort((a, b) {
        final double distanceA = Helper.calculateDistance(
          userLocation.latitude!,
          userLocation.longitude!,
          a['location']['latitude'],
          a['location']['longitude'],
        );
        final double distanceB = Helper.calculateDistance(
          userLocation.latitude!,
          userLocation.longitude!,
          b['location']['latitude'],
          b['location']['longitude'],
        );
        return distanceA.compareTo(distanceB);
      });
  }

  @override
  List<Map<String, dynamic>> sortByRating(
      List<Map<String, dynamic>> restaurants) {
    return List.from(restaurants)
      ..sort((a, b) => b['rate'].compareTo(a['rate']));
  }

  @override
  List<Map<String, dynamic>> getPopularMenu(
      List<Map<String, dynamic>> restaurants) {
    final allMeals = <Map<String, dynamic>>[];

    for (final restaurant in restaurants) {
      final restaurantName = restaurant['name'];
      for (final meal in restaurant['meals']) {
        allMeals.add({
          ...meal,
          'restaurantName': restaurantName,
        });
      }
    }
    allMeals.sort((a, b) => b['rate'].compareTo(a['rate']));
    return allMeals;
  }

  @override
  Future<List<Object?>> getFilteredRestaurants(String mealName) async {
    return await dataSource.fetchRestaurantsByMealName(mealName);
  }

  @override
  Future<(String, List<Map<String, dynamic>>)> searchAndFilter(
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  ) async {
    final restaurants = await dataSource.fetchRestaurantsByMealName(mealName);

    return filterRestaurants(
      restaurants,
      mealName,
      selectedType,
      selectedLocation,
      selectedFoods,
    );
  }

  @override
  Future<(String, List<Map<String, dynamic>>)> filterRestaurants(
    List<Map<String, dynamic>?> restaurants,
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  ) async {
    var filteredMeals = filterByMealName(restaurants, mealName);
    var type = determineType(selectedType);

    if (selectedType.isNotEmpty) {
      filteredMeals = filterByType(filteredMeals, selectedType);
    }

    if (selectedLocation.isNotEmpty) {
      filteredMeals = await filterByLocation(filteredMeals, selectedLocation);
    }

    if (selectedFoods.isNotEmpty) {
      filteredMeals = filterByFoods(filteredMeals, selectedFoods);
    }

    return (type, filteredMeals);
  }

  @override
  List<Map<String, dynamic>> filterByMealName(
    List<Map<String, dynamic>?> restaurants,
    String mealName,
  ) {
    if (mealName.isEmpty) return [];

    final filteredMeals = <Map<String, dynamic>>[];

    for (final restaurant in restaurants) {
      for (final meal in restaurant?['meals'] ?? []) {
        if (isMealNameMatched(meal['name'], mealName)) {
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

  @override
  bool isMealNameMatched(String? mealName, String searchName) {
    return mealName
            ?.toString()
            .toLowerCase()
            .trim()
            .contains(searchName.toLowerCase().trim()) ??
        false;
  }

  @override
  String determineType(String selectedType) {
    if (selectedType.isEmpty) return "Meals";
    return selectedType == "Restaurant" ? "Restaurants" : "Meals";
  }

  @override
  List<Map<String, dynamic>> filterByType(
    List<Map<String, dynamic>> meals,
    String selectedType,
  ) {
    return meals.where((meal) {
      return selectedType == "Restaurant"
          ? meal['restaurant_name'] != null
          : meal['meal_name'] != null;
    }).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> filterByLocation(
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

        return isWithinSelectedDistance(distance, selectedLocation);
      }
      return false;
    }).toList();
  }

  @override
  bool isWithinSelectedDistance(double distance, String selectedLocation) {
    if (selectedLocation == "<10 Km") {
      return distance < 10.0;
    } else if (selectedLocation == ">10 Km") {
      return distance > 10.0;
    } else if (selectedLocation == "1 Km") {
      return distance == 1.0;
    }
    return false;
  }

  @override
  List<Map<String, dynamic>> filterByFoods(
    List<Map<String, dynamic>> meals,
    List<String> selectedFoods,
  ) {
    return meals.where((meal) {
      final mealType = meal['type']?.toString().toLowerCase();
      return mealType != null && selectedFoods.contains(mealType);
    }).toList();
  }
}

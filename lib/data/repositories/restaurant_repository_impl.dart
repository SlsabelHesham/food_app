import 'package:food_app/core/utils/helper.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource.dart';
import 'package:food_app/domain/models/filtered_meal.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'package:food_app/services/location_service.dart';
import 'package:location/location.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDataSource dataSource;

  RestaurantRepositoryImpl(this.dataSource);

  @override
  Future<List<Restaurant>> getAllRestaurants() async {
    return await dataSource.fetchRestaurants();
  }

  @override
  List<Restaurant> sortByDistance(
      List<Restaurant> restaurants, LocationData userLocation) {
    final filteredRestaurants = <Restaurant>[];

    for (final restaurant in restaurants) {
      filteredRestaurants.add(
        Restaurant(
          name: restaurant.name,
          time: restaurant.time,
          image: restaurant.image,
          rate: restaurant.rate,
          location: restaurant.location,
          meals: restaurant.meals,
        ),
      );
    }
    filteredRestaurants.sort((a, b) {
      final distanceA = Helper.calculateDistance(
        userLocation.latitude!,
        userLocation.longitude!,
        a.location.latitude,
        a.location.longitude,
      );

      final distanceB = Helper.calculateDistance(
        userLocation.latitude!,
        userLocation.longitude!,
        b.location.latitude,
        b.location.longitude,
      );

      return distanceA.compareTo(distanceB);
    });

    return filteredRestaurants;
  }

  @override
  List<Restaurant> sortByRating(List<Restaurant> restaurants) {
    final filteredRestaurants = <Restaurant>[];

    for (final restaurant in restaurants) {
      filteredRestaurants.add(
        Restaurant(
          name: restaurant.name,
          time: restaurant.time,
          image: restaurant.image,
          rate: restaurant.rate,
          location: restaurant.location,
          meals: restaurant.meals,
        ),
      );
    }

    filteredRestaurants.sort((a, b) {
      return b.rate.compareTo(a.rate);
    });

    return filteredRestaurants;
  }

  @override
  Future<List<Restaurant>> getFilteredRestaurants(String mealName) async {
    return await dataSource.fetchRestaurantsByMealName(mealName);
  }

  @override
  Future<(String, List<FilteredMeal?>)> searchAndFilter(
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  ) async {
    final restaurants = await dataSource.fetchRestaurantsByMealName(mealName);
    final filteredMeals = await filterRestaurants(
      restaurants,
      mealName,
      selectedType,
      selectedLocation,
      selectedFoods,
    );
    return filteredMeals;
  }

  @override
  Future<(String, List<FilteredMeal?>)> filterRestaurants(
    List<Restaurant> restaurants,
    String mealName,
    String selectedType,
    String selectedLocation,
    List<String> selectedFoods,
  ) async {
    late List<FilteredMeal?> filteredMeals;
    filteredMeals = filterByMealName(restaurants, mealName);
    var type = determineType(selectedType);

    if (filteredMeals.isNotEmpty && selectedType.isNotEmpty) {
      filteredMeals = filterByType(filteredMeals, selectedType);
    }

    if (selectedLocation.isNotEmpty) {
      type = "Restaurants";
      filteredMeals = await filterByLocation(filteredMeals, selectedLocation);
    }

    if (selectedFoods.isNotEmpty) {
      filteredMeals = filterByFoods(filteredMeals, selectedFoods);
    }

    return (type, filteredMeals);
  }

  @override
  List<FilteredMeal> filterByMealName(
      List<Restaurant> restaurants, String mealName) {
    if (mealName.isEmpty) return [];

    return restaurants.expand((restaurant) {
      return restaurant.meals
          .where((meal) => isMealNameMatched(meal.name, mealName))
          .map((meal) {
        return FilteredMeal(
            mealName: meal.name,
            mealImage: meal.image,
            mealPrice: meal.price,
            mealRate: meal.rate,
            restaurantName: restaurant.name,
            restaurantTime: restaurant.time,
            restaurantImage: restaurant.image,
            restaurantRate: restaurant.rate,
            location: restaurant.location,
            type: meal.type);
      });
    }).toList();
  }

  @override
  bool isMealNameMatched(String? mealName, String searchName) {
    return mealName
            ?.toLowerCase()
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
  List<FilteredMeal?> filterByType(
      List<FilteredMeal?> meals, String selectedType) {
    return meals.where((meal) {
      if (meal == null) return false;
      if (selectedType == "Restaurant") {
        return meal.restaurantName.isNotEmpty;
      } else {
        return meal.mealName.isNotEmpty;
      }
    }).toList();
  }

  @override
  Future<List<FilteredMeal?>> filterByLocation(
      List<FilteredMeal?> meals, String selectedLocation) async {
    final locationService = LocationService();
    final userLocation = await locationService.getUserLocation();

    if (userLocation == null) {
      throw Exception("User location not found");
    }

    return meals.where((meal) {
      if (meal == null) return false;

      final distance = Helper.calculateDistance(
        userLocation.latitude ?? 0.0,
        userLocation.longitude ?? 0.0,
        meal.location.latitude,
        meal.location.longitude,
      );

      return isWithinSelectedDistance(distance, selectedLocation);
    }).toList();
  }

  @override
  bool isWithinSelectedDistance(double distance, String selectedLocation) {
    switch (selectedLocation) {
      case "<10 Km":
        return distance < 10.0;
      case ">10 Km":
        return distance > 10.0;
      case "1 Km":
        return distance == 1.0;
      default:
        return false;
    }
  }

  @override
  List<FilteredMeal?> filterByFoods(
      List<FilteredMeal?> meals, List<String> selectedFoods) {
    final hasMatch = meals.any((meal) {
      final mealType = meal?.type.toLowerCase().trim();
      return selectedFoods.any((food) => food.toLowerCase() == mealType);
    });
    if (!hasMatch) return [];

    return meals.where((meal) {
      final mealType = meal?.type.toLowerCase().trim();
      return selectedFoods.any((food) => food.toLowerCase() == mealType);
    }).toList();
  }

  @override
  List<FilteredMeal> getPopularMenu(List<Restaurant> restaurants) {
    final allMeals = <FilteredMeal>[];

    for (final restaurant in restaurants) {
      for (final meal in restaurant.meals) {
        allMeals.add(
          FilteredMeal(
              mealName: meal.name,
              mealImage: meal.image,
              mealPrice: meal.price,
              mealRate: meal.rate,
              restaurantName: restaurant.name,
              restaurantTime: restaurant.time,
              restaurantImage: restaurant.image,
              restaurantRate: restaurant.rate,
              location: restaurant.location,
              type: meal.type),
        );
      }
    }

    allMeals.sort((a, b) => b.mealRate.compareTo(a.mealRate));

    return allMeals;
  }
}

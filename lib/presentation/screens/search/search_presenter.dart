import 'package:food_app/data/datasources/restaurant_datasource.dart';

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

  (String, List<Map<String, dynamic>>) _filterRestaurants(
      List<Map<String, dynamic>?> restaurants,
      String mealName,
      String selectedType,
      String selectedLocation,
      List<String> selectedFoods) {
    var filteredMeals = <Map<String, dynamic>>[];
    var type = "Meals";
      for (final restaurant in restaurants) {
        if (mealName.isNotEmpty) {
          for (final meal in restaurant?['meals']) {
            if (meal['name'] == mealName) {
              filteredMeals.add({
                ...meal,
                'restaurant_name': restaurant?['name'],
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
        // calc distance
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

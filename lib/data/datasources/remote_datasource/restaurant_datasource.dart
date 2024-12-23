import 'package:food_app/domain/models/restaurant.dart';

abstract class RestaurantDataSource {
Future<List<Restaurant>> fetchRestaurants();
Future<List<Restaurant>> fetchRestaurantsByMealName(String mealName);
}
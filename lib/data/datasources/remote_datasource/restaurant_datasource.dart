abstract class RestaurantDataSource {
  Future<List<Map<String, dynamic>>> fetchRestaurants();
  Future<List<Map<String, dynamic>?>> fetchRestaurantsByMealName(String mealName);
}
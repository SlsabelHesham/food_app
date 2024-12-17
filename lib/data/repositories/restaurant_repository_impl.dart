import 'package:food_app/core/utils/helper.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource.dart';
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
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'restaurant_datasource.dart';
import 'package:food_app/core/resources/strings.dart';

class RestaurantDataSourceImpl implements RestaurantDataSource {
  final FirebaseFirestore _firestore;

  RestaurantDataSourceImpl(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> fetchRestaurants() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('restaurants').get();

      return snapshot.docs.map((doc) {
        return {
          "name": doc['name'] ?? Strings.unknownRestaurant,
          "location": {
            "latitude": doc['location']['latitude'] ?? 0,
            "longitude": doc['location']['longitude'] ?? 0,
          },
          "rate": doc['rate'] ?? 0,
          "image": doc['image'] ?? "",
          "time": doc['time'] ?? "- min",
          "meals": List<Map<String, dynamic>>.from(doc['meals'] ?? []),
        };
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch restaurants: $e");
    }
  }

  @override
  Future<List<Map<String, dynamic>?>> fetchRestaurantsByMealName(
      String mealName) async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('restaurants').get();

      return snapshot.docs.map((doc) {
        final meals = List<Map<String, dynamic>>.from(doc['meals'] ?? []);

        final filteredMeals = meals
            .where((meal) => meal['name'].toString().toLowerCase().trim().contains(mealName.toLowerCase().trim()))
            .toList();

        if (filteredMeals.isNotEmpty) {
          return {
            "name": doc['name'] ?? Strings.unknownRestaurant,
            "location": {
              "latitude": doc['location']['latitude'] ?? 0,
              "longitude": doc['location']['longitude'] ?? 0,
            },
            "rate": doc['rate'] ?? 0,
            "time": doc['time'] ?? "- min",
            "image": doc['image'] ?? "",
            "meals": filteredMeals,
          };
        } else {
          return null;
        }
      }).where((restaurant) => restaurant != null).toList();
    } catch (e) {
      throw Exception("Failed to fetch restaurants by meal name: $e");
    }
  }
}
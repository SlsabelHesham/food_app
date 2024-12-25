import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/location.dart';
import 'package:food_app/domain/models/meal.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'restaurant_datasource.dart';

class RestaurantDataSourceImpl implements RestaurantDataSource {
  final FirebaseFirestore _firestore;

  RestaurantDataSourceImpl(this._firestore);

  @override
  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('restaurants').get();

      List<Restaurant> list = snapshot.docs.map((doc) {
        return Restaurant.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return list;
    } catch (e) {
      throw Exception("Failed to fetch restaurants: $e");
    }
  }

  @override
  Future<List<Restaurant>> fetchRestaurantsByMealName(String mealName) async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('restaurants').get();

      return snapshot.docs
          .map((doc) {
            final meals = List<Map<String, dynamic>>.from(doc['meals'] ?? []);
            final filteredMeals = meals
                .where((meal) => meal['name']
                    .toString()
                    .toLowerCase()
                    .trim()
                    .contains(mealName.toLowerCase().trim()))
                .toList();
            if (filteredMeals.isNotEmpty) {
              return Restaurant(
                name: doc['name'] ?? Strings.unknownRestaurant,
                location: Location(
                  latitude: (doc['location']['latitude'] ?? 0),
                  longitude: (doc['location']['longitude'] ?? 0),
                ),
                rate: (doc['rate'] as num).toDouble(),
                time: doc['time'] ?? '- min',
                logo: doc['logo'] ?? '',
                description: doc['description'] ?? '',
                image: doc['image'] ?? '',
                meals: filteredMeals.map((meal) => Meal.fromMap(meal)).toList(),
              );
            }
            return null;
          })
          .where((restaurant) => restaurant != null)
          .cast<Restaurant>()
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch restaurants by meal name: $e");
    }
  }
}

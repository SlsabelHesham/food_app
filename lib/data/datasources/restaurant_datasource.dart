import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/core/resources/strings.dart';

class RestaurantDataSource {
  Future<List<Map<String, dynamic>>> fetchRestaurants() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('restaurants').get();

    return snapshot.docs
        .map((doc) => {
              "name": doc['name'] ?? Strings.unknownRestaurant,
              "location": {
                "latitude": doc['location']['latitude'],
                "longitude": doc['location']['longitude'],
              },
              "rate": doc['rate'] ?? 0,
              "image": doc['image'] ?? "image",
              "time": doc['time'] ?? "-5 min",
              "meals": List<Map<String, dynamic>>.from(doc['meals'] ?? []),
            })
        .toList();
  }

  Future<List<Map<String, dynamic>?>> fetchRestaurantsByMealName(
      String mealName) async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();
      return snapshot.docs
          .map((doc) {
            final meals = List<Map<String, dynamic>>.from(doc['meals'] ?? []);

            final filteredMeals =
                meals.where((meal) => meal['name'] == mealName).toList();

            if (filteredMeals.isNotEmpty) {
              return {
                "name": doc['name'] ?? 'Unknown Restaurant',
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
          })
          .where((restaurant) => restaurant != null)
          .toList();
    } catch (e) {
      return [];
    }
  }
}

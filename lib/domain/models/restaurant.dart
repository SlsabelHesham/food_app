import 'package:food_app/domain/models/location.dart';
import 'package:food_app/domain/models/meal.dart';

class Restaurant {
  final String name;
  final Location location;
  final double rate;
  final String image;
  final String time;
  final List<Meal> meals;

  Restaurant({
    required this.name,
    required this.location,
    required this.rate,
    required this.image,
    required this.time,
    required this.meals,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'] ?? 'Unknown Restaurant',
      location: Location.fromMap(map['location'] ?? {}),
      rate: (map['rate'] as num).toDouble(),
      image: map['image'] ?? '',
      time: map['time'] ?? '- min',
      meals: List<Map<String, dynamic>>.from(map['meals'] ?? [])
          .map((meal) => Meal.fromMap(meal))
          .toList(),
    );
  }
}
import 'package:food_app/domain/models/location.dart';

class FilteredMeal {
  final String mealName;
  final String mealImage;
  final String mealPrice;
  final double mealRate;
  final String restaurantName;
  final String restaurantTime;
    final String restaurantLogo;
  final String restaurantDescription;

  final String restaurantImage;
  final double restaurantRate;
  final Location location;
  final String type;

  FilteredMeal({
    required this.mealName,
    required this.mealImage,
    required this.mealPrice,
    required this.mealRate,
    required this.restaurantName,
    required this.restaurantTime,
        required this.restaurantLogo,
    required this.restaurantDescription,

    required this.restaurantImage,
    required this.restaurantRate,
    required this.location,
    required this.type,
  });

  factory FilteredMeal.fromMap(Map<String, dynamic> map) {
    return FilteredMeal(
      mealName: map['mealName'] ?? '',
      mealImage: map['mealImage'] ?? '',
      mealPrice: (map['mealPrice']),
      mealRate: (map['mealRate'] as num).toDouble(),
      restaurantName: map['restaurantName'] ?? 'Unknown Restaurant',
      restaurantTime: map['restaurantTime'] ?? '- min',
            restaurantLogo: map['restaurantLogo'] ?? '',
      restaurantDescription: map['restaurantDescription'] ?? '',

      restaurantImage: map['restaurantImage'] ?? '',
      restaurantRate: (map['restaurantRate'] as num).toDouble(),
      location: Location.fromMap(map['location'] ?? {}),
      type: map['type'],
    );
  }
}
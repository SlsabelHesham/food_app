import 'package:flutter/material.dart';
import 'package:food_app/domain/models/menu_item.dart';
import 'package:food_app/domain/models/restaurants.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/popular_menu_widget.dart';
import 'package:food_app/presentation/widgets/restaurant_card_widget.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String key = data['type'];
    final List<dynamic> value = data['restaurants'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 254),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (value.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    "No search result",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              Expanded(
                child: key == "Meals"
                    ? _buildPopularMenu(
                        value.map((meal) {
                          return {
                            'name': meal['meal_name'] ?? "",
                            'restaurantName': meal['restaurant_name'] ?? "",
                            'image': meal['meal_image'] ?? "",
                            'price': meal['meal_price'].toString(),
                          };
                        }).toList(),
                      )
                    : _buildRestaurantListContent(
                        value.map((restaurant) {
                          return {
                            'name': restaurant['restaurant_name'] ?? "",
                            'time': restaurant['restaurant_time'] ?? "",
                            'image': restaurant['restaurant_image'] ?? "",
                          };
                        }).toList(),
                      ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantListContent(List<Map<String, dynamic>> restaurants) {
    List<Restaurant> restaurantsItems = restaurants.map((restaurant) {
      return Restaurant(
        name: restaurant['name'] ?? 'Unknown',
        time: restaurant['time'] ?? 'Unknown',
        imageUrl: restaurant['image'] ?? '',
      );
    }).toList();
    return RestaurantGridContent(restaurants: restaurantsItems);
  }

  Widget _buildPopularMenu(List<Map<String, dynamic>> meals) {
    List<MenuItem> menuItems = meals.map((meal) {
      return MenuItem(
        name: meal['name'] ?? 'Unknown',
        restaurantName: meal['restaurantName'] ?? 'Unknown',
        imageUrl: meal['image'] ?? '',
        price: meal['price'] ?? '0.00',
      );
    }).toList();

    return PopularMenu(meals: menuItems);
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: "Find Your \nFavorite Food",
      imageAsset: "assets/images/pattern.png",
    );
  }
}

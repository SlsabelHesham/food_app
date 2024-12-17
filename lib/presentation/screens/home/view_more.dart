import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/menu_item.dart';
import 'package:food_app/domain/models/restaurants.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/popular_menu_widget.dart';
import 'package:food_app/presentation/widgets/restaurant_card_widget.dart';

class ViewMoreScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ViewMoreScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String type = data['type'] ?? "";
    final List<dynamic> value = data['items'] ?? [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: value.isEmpty
                  ? const Center(child: Text("No items available"))
                  : type == "Meals"
                      ? _buildPopularMenu(
                          value.map((meal) {
                            return {
                              'name': meal['name'] ?? "",
                              'restaurantName': meal['restaurantName'] ?? "",
                              'image': meal['image'] ?? "",
                              'price': meal['price'].toString(),
                            };
                          }).toList(),
                        )
                      : _buildRestaurantListContent(
                          value.map((restaurant) {
                            return {
                              'name': restaurant['name'] ?? "",
                              'time': restaurant['time'] ?? "",
                              'image': restaurant['image'] ?? "",
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
    List<Restaurant> restaurantItems = restaurants.map((restaurant) {
      return Restaurant(
        name: restaurant['name'] ?? 'Unknown',
        time: restaurant['time'] ?? 'Unknown',
        imageUrl: restaurant['image'] ?? '',
      );
    }).toList();
    return RestaurantGridContent(restaurants: restaurantItems);
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
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }
}
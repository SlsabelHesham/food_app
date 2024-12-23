import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/filtered_meal.dart';
import 'package:food_app/domain/models/restaurant.dart';
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
                          value as List<FilteredMeal>,
                        )
                      : _buildRestaurantListContent(
                          value as List<Restaurant>,
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantListContent(List<Restaurant> restaurants) {
    return RestaurantGridContent(restaurants: restaurants);
  }

  Widget _buildPopularMenu(List<FilteredMeal> meals) {
    return PopularMenu(meals: meals);
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/meal.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'package:food_app/presentation/widgets/inside_menu_card.dart';
import 'package:food_app/styles/text_styles.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
            child: FadeInImage.assetNetwork(
              placeholder: Strings.loadingImage,
              image: restaurant.logo,
              height: 90,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25, top: 17),
            child: Text(
              restaurant.name,
              style: TextStyles.cardTitle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 26),
            child: Text(
              restaurant.time,
              style: TextStyles.cardSecondTitle(context),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantListContent extends StatelessWidget {
  final List<Restaurant> restaurants;
  final Function(Restaurant) onRestaurantTap;

  const RestaurantListContent({
    super.key,
    required this.restaurants,
    required this.onRestaurantTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () => onRestaurantTap(restaurant),
                child: RestaurantCard(restaurant: restaurant),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RestaurantGridContent extends StatelessWidget {
  final List<Restaurant> restaurants;
  final Function(Restaurant) onRestaurantTap;

  const RestaurantGridContent({
    super.key,
    required this.restaurants,
    required this.onRestaurantTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => onRestaurantTap(restaurant),
              child: RestaurantCard(restaurant: restaurant),
            ),
          );
        },
      ),
    );
  }
}

class MealGridContent extends StatelessWidget {
  final List<Meal> meals;

  const MealGridContent({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3.5 / 4,
        ),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return InsideMenuCard(meal: meal);
        },
      ),
    );
  }
}

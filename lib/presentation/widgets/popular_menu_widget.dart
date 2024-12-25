import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/filtered_meal.dart';
import 'package:food_app/styles/text_styles.dart';

class PopularMenu extends StatelessWidget {
  final List<FilteredMeal> meals;

  const PopularMenu({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: meals.map((meal) => MenuCard(meal: meal)).toList(),
    );
  }
}

class MenuCard extends StatelessWidget {
  final FilteredMeal meal;

  const MenuCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        height: 87,
        child: Row(
          children: [
            if (meal.mealImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                  placeholder: Strings.loadingImage,
                  image: meal.mealImage,
                  height: 64,
                  width: 64,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealName,
                    style: TextStyles.cardTitle(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meal.restaurantName,
                    style: TextStyles.cardSecondTitle(context),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    meal.mealPrice,
                    style: TextStyles.priceText(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

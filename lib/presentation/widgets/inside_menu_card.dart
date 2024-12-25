import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/meal.dart';
import 'package:food_app/styles/text_styles.dart';

class InsideMenuCard extends StatelessWidget {
  final Meal meal;

  const InsideMenuCard({super.key, required this.meal});

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
              image: meal.image,
              height: 90,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5, top: 17),
            child: Text(
              meal.name,
              style: TextStyles.cardTitle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 26),
            child: Text(
              meal.price,
              style: TextStyles.cardSecondTitle(context),
            ),
          ),
        ],
      ),
    );
  }
}

class MealsListContent extends StatelessWidget {
  final List<Meal> meals;

  const MealsListContent({
    super.key,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InsideMenuCard(meal: meal),

            );
          },
        ),
      ),
    );
  }
}
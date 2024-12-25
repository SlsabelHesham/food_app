import 'package:flutter/material.dart';
import 'package:food_app/domain/models/meal.dart';
import 'package:food_app/presentation/widgets/inside_menu_card.dart';

class DetailMealsList extends StatelessWidget {
  final List<Meal> meals;

  const DetailMealsList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return MealsListContent(meals: meals);
  }
}
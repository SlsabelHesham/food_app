import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'package:food_app/presentation/widgets/detail_header_widget.dart';
import 'package:food_app/presentation/widgets/detail_meal_list_widget.dart';
import 'package:food_app/presentation/widgets/section_title_widget.dart';
import 'detail_description.dart';

class DetailContent extends StatelessWidget {
  final ScrollController scrollController;
  final Restaurant restaurant;

  const DetailContent({
    super.key,
    required this.scrollController,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 21.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailHeader(restaurant: restaurant),
              const SizedBox(height: 16),
              DetailDescription(description: restaurant.description),
              const SizedBox(height: 16),
              SectionTitle(
                title: "Popular Menu",
                onViewMore: () {
                  Navigator.pushNamed(
                    context,
                    Strings.viewMoreScreen,
                    arguments: {
                      'type': "InsideMeals",
                      'items': restaurant.meals,
                    },
                  );
                },
              ),
              DetailMealsList(meals: restaurant.meals),
            ],
          ),
        ),
      ),
    );
  }
}

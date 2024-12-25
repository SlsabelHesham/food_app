import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'package:food_app/presentation/widgets/detail_distance_widget.dart';
import 'package:food_app/presentation/widgets/details_rating_widget.dart';
import 'package:food_app/presentation/widgets/favorite_button_widget.dart';
import 'package:food_app/presentation/widgets/image_button_widget.dart';
import 'package:food_app/styles/text_styles.dart';

class DetailHeader extends StatelessWidget {
  final Restaurant restaurant;

  const DetailHeader({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Popular",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                CustomImageButton(
                  imagePath: 'assets/images/Shape.png',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Strings.mapScreen,
                      arguments: restaurant.location,
                    );
                  },
                ),
                const SizedBox(width: 8),
                const ToggleFavoriteButton(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              restaurant.name,
              style: TextStyles.detailsTitle(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const DetailDistanceWidget(),
            const SizedBox(width: 4),
            DetailRatingWidget(restaurantRating: restaurant.rate)
          ],
        ),
      ],
    );
  }
}

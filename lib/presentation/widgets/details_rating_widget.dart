import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/core/resources/strings.dart';

class DetailRatingWidget extends StatelessWidget {
  final double restaurantRating;

  const DetailRatingWidget({
    super.key,
    required this.restaurantRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar(
          initialRating: restaurantRating / 100,
          minRating: 0,
          itemSize: 20.0,
          itemCount: 1,
          ratingWidget: RatingWidget(
            full: _image(Strings.starFullImage),
            half: _image(Strings.starHalfImage),
            empty: _image(Strings.starBorderImage),
          ),
          onRatingUpdate: (newRating) {

          },
          ignoreGestures: true,
          glow: false,
          allowHalfRating: true,
        ),
        const SizedBox(width: 4),
        Text(
          "${restaurantRating.toStringAsFixed(1)} Rating",
          style: TextStyle(
            fontFamily: 'BentonSans',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.8,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _image(String assetPath) {
    return Image.asset(
      assetPath,
      width: 24,
      height: 24,
    );
  }
}
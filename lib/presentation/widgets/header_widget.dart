import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class HeaderWidget extends StatelessWidget {
  final String headerText;
  final String imageAsset;

  const HeaderWidget({
    super.key,
    required this.headerText,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 31, bottom: 18),
            child: Text(
              headerText,
              style: TextStyles.headerHeadline(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 39),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 196, 192, 192)
                        .withOpacity(0.15),
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 11, bottom: 11, left: 14, right: 14),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage("assets/images/icon_notification.png"),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

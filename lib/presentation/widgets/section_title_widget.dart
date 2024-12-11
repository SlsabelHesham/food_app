import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewMore;
  final String viewMoreText;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onViewMore,
    this.viewMoreText = "View More",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 31.0, right: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.mainTitle(),
          ),
          TextButton(
            onPressed: onViewMore,
            child: Text(
              viewMoreText,
              style: TextStyles.secondTitle(context),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class DetailDescription extends StatelessWidget {
  final String description;

  const DetailDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyles.descriptionTitle(context),
    );
  }
}
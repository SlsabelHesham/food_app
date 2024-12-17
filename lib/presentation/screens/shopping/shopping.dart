import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class Shopping extends StatelessWidget {
  

  const Shopping({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Shopping", style: TextStyles.headerHeadline(context)));
  }
}
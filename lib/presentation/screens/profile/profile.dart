import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class Profile extends StatelessWidget {
  

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile", style: TextStyles.headerHeadline(context)));
  }
}
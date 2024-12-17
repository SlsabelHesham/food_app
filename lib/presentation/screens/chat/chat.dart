import 'package:flutter/material.dart';
import 'package:food_app/styles/text_styles.dart';

class Chat extends StatelessWidget {
  

  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Chat", style: TextStyles.headerHeadline(context)));
  }
}
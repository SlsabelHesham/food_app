
import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  final String imagePath;
  final Function() onPressed;

  const CustomImageButton(
      {super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 237, 252, 243),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            width: 17,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ToggleFavoriteButton extends StatefulWidget {
  const ToggleFavoriteButton({super.key});

  @override
  ToggleFavoriteButtonState createState() => ToggleFavoriteButtonState();
}

class ToggleFavoriteButtonState extends State<ToggleFavoriteButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 248, 220, 223),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
          size: 16,
        ),
      ),
    );
  }
}

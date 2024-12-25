import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String imagePath;

  const DetailImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: imagePath,
      height: 442,
      fit: BoxFit.contain,
    );
  }
}
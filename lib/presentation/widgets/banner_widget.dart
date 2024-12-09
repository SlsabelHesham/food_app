import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String imageAsset;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  const BannerWidget({
    super.key,
    required this.imageAsset,
    this.height = 150.0,
    this.width = double.infinity,
    this.padding = const EdgeInsets.only(left: 25, right: 25, bottom: 25),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

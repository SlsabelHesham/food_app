import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewMore;
  final String viewMoreText;
  final TextStyle titleStyle;
  final TextStyle viewMoreStyle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onViewMore,
    this.viewMoreText = "View More",
    this.titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    this.viewMoreStyle = const TextStyle(
      color: Color.fromARGB(255, 255, 124, 50),
    ),
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
            style: titleStyle,
          ),
          TextButton(
            onPressed: onViewMore,
            child: Text(
              viewMoreText,
              style: viewMoreStyle,
            ),
          ),
        ],
      ),
    );
  }
}

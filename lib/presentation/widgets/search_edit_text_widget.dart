import 'package:flutter/material.dart';

class SearchEditText extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String hintText;
  final String searchIconAsset;
  final Color hintColor;
  final Color fillColor;
  final Color iconColor;
  final VoidCallback onTap;

  const SearchEditText({
    super.key,
    required this.controller,
    required this.enabled,
    required this.hintText,
    required this.searchIconAsset,
    required this.hintColor,
    required this.fillColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: TextField(
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            prefixIcon: Image.asset(searchIconAsset),
            prefixIconColor: iconColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: fillColor,
          ),
        ),
    );
  }
}

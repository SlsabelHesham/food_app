import 'package:flutter/material.dart';

class GenericChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const GenericChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = const Color.fromARGB(255, 249, 168, 77),
    this.unselectedColor = const Color.fromARGB(255, 249, 168, 77),
    this.selectedTextColor = const Color.fromARGB(255, 218, 99, 23),
    this.unselectedTextColor = const Color.fromARGB(255, 218, 99, 23),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withOpacity(0.5)
              : unselectedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? selectedTextColor : unselectedTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

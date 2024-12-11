import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle headerHeadline(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w700,
      fontSize: 31,
      height: 40.62 / 31,
      color: colorScheme.surfaceDim,
    );
  }

  static TextStyle mainTitle() {
    return const TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w700,
      fontSize: 15,
      height: 19.65 / 15,
    );
  }

  static TextStyle secondTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
        fontFamily: 'BentonSans',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 15.72 / 12,
        color: colorScheme.primaryContainer);
  }

  static TextStyle cardTitle() {
    return const TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 20.96 / 16,
    );
  }

  static TextStyle cardSecondTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
        fontFamily: 'BentonSans',
        fontWeight: FontWeight.w400,
        fontSize: 13,
        height: 17.03 / 13,
        color: colorScheme.outlineVariant
    );
  }

  static TextStyle priceText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
        fontFamily: 'BentonSans',
        fontWeight: FontWeight.w400,
        fontSize: 22,
        height: 28.83 / 22,
        color: colorScheme.onTertiaryContainer
    );
  }

  static TextStyle buttonText() {
    return const TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 14.14 / 14,
      letterSpacing: 0.5,
      color: Colors.white
    );
  }
}

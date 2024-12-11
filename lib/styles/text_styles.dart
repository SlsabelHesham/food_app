import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle headerHeadline() {
    return const TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w700,
      fontSize: 31,
      height: 40.62 / 31,
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

  static TextStyle secondTitle() {
    return const TextStyle(
      fontFamily: 'BentonSans', 
      fontWeight: FontWeight.w400,
      fontSize: 12, 
      height: 15.72 / 12,
    );
  }

  static TextStyle cardTitle() {
    return const TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w400, 
      fontSize: 16, 
      height: 20.96 / 16,
    );
  }

  static TextStyle cardSecondTitle() {
    return const TextStyle(
      fontFamily: 'BentonSans',
      fontWeight: FontWeight.w400, 
      fontSize: 13, 
      height: 17.03 / 13,
    );
  }

  static TextStyle priceText() {
    return const TextStyle(
      fontFamily: 'BentonSans', 
      fontWeight: FontWeight.w400,
      fontSize: 22,
      height: 28.83 / 22,
    );
  }
}

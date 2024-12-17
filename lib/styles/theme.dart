import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff15BE77),
      onPrimary: Color(0xffFFFFFF),
      secondary: Color(0xff5BAE9A),
      onSecondary: Color(0xff000000),
      error: Color(0xFFBA1A1A),
      onError: Color(0xffFF4545),
      surface: Color(0xFFF5F6FE),
      onSurface: Color(0xFF191C20),
      onPrimaryContainer: Color(0xffDA6317),
      primaryContainer: Color(0xffDA6317),
      scrim: Color(0xffFF7C32),
      surfaceDim: Color(0xff000000),
      outlineVariant: Color(0xff808080),
      onTertiaryContainer: Color(0xffFEAD1D),
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff15BE77),
      iconTheme: IconThemeData(color: Color(0xffFFFFFF)),
    ),
    chipTheme: const ChipThemeData(
      side: BorderSide.none,
    )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff0D0D0D),
      onPrimary: Color(0xff3B3B3B),
      secondary: Color(0xff26362E),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFF111318),
      onSurface: Color(0xFFE1E2E9),
      onPrimaryContainer: Color(0xFFFFFFFF),
      primaryContainer: Color(0xffDA6317),
      scrim: Color(0xffFF7C32),
      surfaceDim: Color(0xffFFFFFF),
      outlineVariant: Color(0xff808080),
      onTertiaryContainer: Color(0xffFEAD1D),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff15BE77),
      iconTheme: IconThemeData(color: Color(0xffFFFFFF)),
    ),
    chipTheme: const ChipThemeData(
      side: BorderSide.none,
    )
  );

  static String getSearchIconAsset(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? "assets/images/icon_search_dark.png"
        : "assets/images/icon_search.png";
  }

  static String getFilterIconAsset(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? "assets/images/filter_dark.png"
        : "assets/images/filter.png";
  }
}
import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/presentation/screens/main_screen.dart';
import 'package:food_app/presentation/screens/search/search_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case Strings.filterScreen:
        return MaterialPageRoute(builder: (_) => const FilterScreen());
    }
    return null;
  }
}

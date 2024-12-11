import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/presentation/screens/main_screen.dart';
import 'package:food_app/presentation/screens/search/result_screen.dart';
import 'package:food_app/presentation/screens/search/search_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case Strings.filterScreen:
        final searchBloc = settings.arguments as SearchBloc;
        return MaterialPageRoute(
          builder: (_) => FilterScreen(searchBloc: searchBloc),
        );

      case Strings.resultScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ResultsScreen(data: data),
        );
    }
    return null;
  }
}

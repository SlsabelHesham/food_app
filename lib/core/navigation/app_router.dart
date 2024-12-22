import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource_impl.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/data/repositories/restaurant_repository_impl.dart';
import 'package:food_app/domain/bloc/home/home_bloc.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/presentation/screens/home/view_more.dart';
import 'package:food_app/presentation/screens/main_screen.dart';
import 'package:food_app/presentation/screens/search/result_screen.dart';
import 'package:food_app/presentation/screens/search/search_screen.dart';

class AppRouter {
  late RestaurantDataSource restaurantDataSource;
  late RestaurantRepository restaurantRepository;

  AppRouter() {
    restaurantDataSource = RestaurantDataSourceImpl(FirebaseFirestore.instance);
    restaurantRepository = RestaurantRepositoryImpl(restaurantDataSource);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => HomeBloc(restaurantRepository),
            child: const MainScreen(),
          ),
        );

      case Strings.filterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => SearchBloc(restaurantRepository),
            child: const FilterScreen(),
          ),
        );

      case Strings.resultScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => SearchBloc(restaurantRepository),
            child: ResultsScreen(data: data),
          ),
        );

      case Strings.viewMoreScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ViewMoreScreen(data: data),
        );
    }
    return null;
  }
}

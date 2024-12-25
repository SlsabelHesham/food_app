import 'package:food_app/domain/models/filtered_meal.dart';
import 'package:food_app/domain/models/restaurant.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Restaurant> nearestRestaurants;
  final List<FilteredMeal> popularMenu;
  final List<Restaurant> popularRestaurants;

  HomeLoaded({
    required this.nearestRestaurants,
    required this.popularMenu,
    required this.popularRestaurants,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

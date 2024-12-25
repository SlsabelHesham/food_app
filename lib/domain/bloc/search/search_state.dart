import 'package:food_app/domain/models/filtered_meal.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final String type;
  final List<FilteredMeal?> restaurants;

  SearchLoaded({required this.type, required this.restaurants});
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

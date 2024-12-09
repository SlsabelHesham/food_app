abstract class FilterState {}

class FilterInitialState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadedState extends FilterState {
  final List<Map<String, dynamic>> filteredMeals;

  FilterLoadedState(this.filteredMeals);
}

class FilterErrorState extends FilterState {
  final String error;

  FilterErrorState(this.error);
}

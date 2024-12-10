abstract class SearchState {}

class SearchInitialState extends SearchState {}

class FilterLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Map<String, dynamic>> filteredMeals;

  SearchLoadedState(this.filteredMeals);
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);
}

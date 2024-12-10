import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurantRepository repository;

  String _searchQuery = "";
  final String _selectedType = "";
  final String _selectedLocation = "";
  final List<String> _selectedFoods = [];

  SearchBloc(this.repository) : super(SearchInitialState()) {
    on<SearchQueryChanged>((event, emit) {
      _searchQuery = event.searchQuery;
    });



    on<ApplyFilters>((event, emit) async {
      emit(FilterLoadingState());

      try {
        final results = await repository.getAllRestaurants();

        List<Map<String, dynamic>> filteredMeals =
            repository.filterRestaurants(results, _searchQuery, _selectedType,
                _selectedLocation, _selectedFoods);

        emit(SearchLoadedState(filteredMeals));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final RestaurantRepository repository;

  String _searchQuery = "";
  String _selectedType = "";
  String _selectedLocation = "";
  List<String> _selectedFoods = [];

  FilterBloc(this.repository) : super(FilterInitialState()) {
    on<SearchQueryChanged>((event, emit) {
      _searchQuery = event.searchQuery;
    });

    on<FilterTypeChanged>((event, emit) {
      _selectedType = event.selectedType;
    });

    on<FilterLocationChanged>((event, emit) {
      _selectedLocation = event.selectedLocation;
    });

    on<FilterFoodsChanged>((event, emit) {
      _selectedFoods = event.selectedFoods;
    });

    on<ApplyFilters>((event, emit) async {
      emit(FilterLoadingState());

      try {
        final results = await repository.getAllRestaurants();

        // فلترة النتائج
        List<Map<String, dynamic>> filteredMeals =
            repository.filterRestaurants(results, _searchQuery, _selectedType,
                _selectedLocation, _selectedFoods);

        emit(FilterLoadedState(filteredMeals));
      } catch (e) {
        emit(FilterErrorState(e.toString()));
      }
    });
  }
}

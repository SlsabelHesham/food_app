import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurantRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<Search>(_onSearch);
  }

  Future<void> _onSearch(Search event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final (type, restaurants) = await repository.searchAndFilter(
        event.mealName,
        event.selectedType,
        event.selectedLocation,
        event.selectedFoods,
      );
      emit(SearchLoaded(type: type, restaurants: restaurants));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

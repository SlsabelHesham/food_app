import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';
import 'package:food_app/presentation/screens/search/search_presenter.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurantPresenter presenter;

  SearchBloc(this.presenter) : super(LoadingState()) {
    on<SearchEvent>(_onSearch);
  }

  Future<void> _onSearch(SearchEvent event, Emitter<SearchState> emit) async {
    emit(LoadingState());
    try {
      final (type, restaurants) = await presenter.searchAndFilter(
        event.mealName,
        event.selectedType,
        event.selectedLocation,
        event.selectedFoods,
      );
      
      emit(LoadedState(type: type, restaurants: restaurants));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}

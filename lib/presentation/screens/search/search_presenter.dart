import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';

class SearchPresenter {
  final SearchBloc _searchBloc;

  SearchPresenter(this._searchBloc);

  void search(String mealName, String selectedType, String selectedLocation,
      List<String> selectedFoods) {
    if (mealName.isNotEmpty) {
      _searchBloc.add(
          (Search(mealName, selectedType, selectedLocation, selectedFoods)));
    } else {
      _searchBloc.add(SearchError("Meal name can't be empty") as SearchEvent);
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../../data/repositories/restaurant_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RestaurantRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      final restaurants = await repository.getAllRestaurants();

      final nearestRestaurants =
          repository.sortByDistance(restaurants, event.userLocation);

      final popularRestaurants = repository.sortByRating(restaurants);

      final popularMenu = repository.getPopularMenu(restaurants);

      emit(HomeLoaded(
        nearestRestaurants: nearestRestaurants,
        popularMenu: popularMenu,
        popularRestaurants: popularRestaurants,
      ));
    } catch (e) {
      emit(HomeError("Failed to load data: $e"));
    }
  }
}

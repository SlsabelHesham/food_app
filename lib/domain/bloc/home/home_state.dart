abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> nearestRestaurants;
  final List<Map<String, dynamic>> popularMenu;
  final List<Map<String, dynamic>> popularRestaurants;

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

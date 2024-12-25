abstract class DetailScreenState {}

class DetailScreenInitial extends DetailScreenState {}

class DistanceLoadingState extends DetailScreenState {}

class DistanceLoadedState extends DetailScreenState {
  final double distance;

  DistanceLoadedState(this.distance);
}

class DistanceErrorState extends DetailScreenState {
  final String error;

  DistanceErrorState(this.error);
}
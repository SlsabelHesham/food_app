import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/helper.dart';
import 'package:food_app/domain/bloc/details/bloc/details_event.dart';
import 'package:food_app/domain/bloc/details/bloc/details_state.dart';

class DetailScreenBloc extends Bloc<DetailScreenEvent, DetailScreenState> {
  DetailScreenBloc() : super(DetailScreenInitial()) {
    on<FetchDistanceEvent>(_onFetchDistance);
  }
  Future<void> _onFetchDistance(
      FetchDistanceEvent event, Emitter<DetailScreenState> emit) async {
    emit(DistanceLoadingState());
    try {
      double distance = Helper.calculateDistance(
        event.userLat, 
        event.userLon, 
        event.restaurantLat, 
        event.restaurantLon,
      );
      emit(DistanceLoadedState(distance));
    } catch (e) {
      emit(DistanceErrorState("Error calculating distance: $e"));
    }
  }
}
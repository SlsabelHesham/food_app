import 'package:food_app/domain/bloc/home/home_bloc.dart';
import 'package:food_app/domain/bloc/home/home_event.dart';
import 'package:food_app/domain/bloc/home/home_state.dart';
import 'package:food_app/services/location_service.dart';
import 'package:location/location.dart';

class HomePresenter {
  final HomeBloc _homeBloc;

  HomePresenter(this._homeBloc);

  Future<void> loadHomeData() async {
    LocationService locationService = LocationService();
    try {
      LocationData? userLocation = await locationService.getUserLocation();
      if (userLocation != null) {
        _homeBloc.add(LoadHomeData(userLocation));
      } else {
        _homeBloc.add(HomeError("Location not found") as HomeEvent);
      }
    } catch (e) {
      _homeBloc.add(HomeError("Error fetching location: $e") as HomeEvent);
    }
  }
}

import 'package:food_app/domain/bloc/details/bloc/details_bloc.dart';
import 'package:food_app/domain/bloc/details/bloc/details_event.dart';
import 'package:food_app/domain/bloc/details/bloc/details_state.dart';
import 'package:food_app/services/location_service.dart';
import 'package:location/location.dart';

class DetailScreenPresenter {
  final DetailScreenBloc bloc;

  DetailScreenPresenter(this.bloc);

  Future<void> fetchUserLocationAndDistance({
    required double restaurantLat,
    required double restaurantLon,
  }) async {
    try {
      LocationService locationService = LocationService();

      LocationData? userLocation = await locationService.getUserLocation();

      if (userLocation != null) {
        bloc.add(FetchDistanceEvent(
          userLat: userLocation.latitude!,
          userLon: userLocation.longitude!,
          restaurantLat: restaurantLat,
          restaurantLon: restaurantLon,
        ));
      } else {
        bloc.add(
            DistanceErrorState("User location not found") as DetailScreenEvent);
      }
    } catch (e) {
      bloc.add(DistanceErrorState("Error fetching user location: $e")
          as DetailScreenEvent);
    }
  }
}

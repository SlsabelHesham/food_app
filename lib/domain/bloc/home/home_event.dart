import 'package:location/location.dart';

abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {
  final LocationData userLocation;
  
  LoadHomeData(this.userLocation);
}

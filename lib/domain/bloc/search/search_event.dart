import 'package:equatable/equatable.dart';

abstract class SearchEventClass extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEvent extends SearchEventClass {
  final String mealName;
  final String selectedType;
  final String selectedLocation;
  final List<String> selectedFoods;

  SearchEvent({
    required this.mealName,
    required this.selectedType,
    required this.selectedLocation,
    required this.selectedFoods,
  });

  @override
  List<Object> get props =>
      [mealName, selectedType, selectedLocation, selectedFoods];
}

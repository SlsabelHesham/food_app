abstract class SearchEvent {}

class Search extends SearchEvent {
  final String mealName;
  final String selectedType;
  final String selectedLocation;
  final List<String> selectedFoods;
  
  Search(this.mealName, this.selectedType, this.selectedLocation, this.selectedFoods);
}
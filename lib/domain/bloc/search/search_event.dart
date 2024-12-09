abstract class FilterEvent {}

class SearchQueryChanged extends FilterEvent {
  final String searchQuery;

  SearchQueryChanged(this.searchQuery);
}

class FilterTypeChanged extends FilterEvent {
  final String selectedType;

  FilterTypeChanged(this.selectedType);
}

class FilterLocationChanged extends FilterEvent {
  final String selectedLocation;

  FilterLocationChanged(this.selectedLocation);
}

class FilterFoodsChanged extends FilterEvent {
  final List<String> selectedFoods;

  FilterFoodsChanged(this.selectedFoods);
}

class ApplyFilters extends FilterEvent {}

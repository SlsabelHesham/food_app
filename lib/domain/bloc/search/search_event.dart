abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String searchQuery;

  SearchQueryChanged(this.searchQuery);
}



class ApplyFilters extends SearchEvent {}

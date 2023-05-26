




















abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;

  PerformSearch(this.query);
}

class ClearSearch extends SearchEvent {}

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<String> searchResults;

  SearchSuccess(this.searchResults);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {}

import 'package:bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is PerformSearch) {
      yield SearchLoading();

      try {
        // Simulate API call or database query
        // Replace this with your actual search logic
        await Future.delayed(Duration(seconds: 2));

        if (event.query.isNotEmpty) {
          // Filter the search results based on the query
          final filteredResults = _getSearchResults(event.query);
          if (filteredResults.isNotEmpty) {
            yield SearchSuccess(filteredResults);
          } else {
            yield SearchEmpty();
          }
        } else {
          yield SearchEmpty();
        }
      } catch (e) {
        yield SearchError();
      }
    } else if (event is ClearSearch) {
      yield SearchInitial();
    }
  }

  List<String> _getSearchResults(String query) {
    // Replace this with your actual search implementation
    // Perform filtering based on the query and return the results
    // This is a dummy example that returns a list of strings containing the query
    final List<String> allResults = [
      'Apple',
      'Banana',
      'Cherry',
      'Grapes',
      'Lemon',
      'Orange',
      'Strawberry',
      'Watermelon',
    ];

    return allResults
        .where((result) => result.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}




















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

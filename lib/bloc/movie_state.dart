// lib/bloc/movie_state.dart
import '../models/movie_model.dart';

class MovieState {
  final List<Movie> allMovies;
  final List<Movie> displayedMovies;
  final String? activeGenre;
  final String searchQuery;
  final bool isLoadingMore;
  final bool hasMore;
  final Movie? selectedMovie;
  final int limit;
  final int offset;

  MovieState({
    required this.allMovies,
    required this.displayedMovies,
    required this.activeGenre,
    required this.searchQuery,
    required this.isLoadingMore,
    required this.hasMore,
    required this.selectedMovie,
    required this.limit,
    required this.offset,
  });

  MovieState copyWith({
    List<Movie>? allMovies,
    List<Movie>? displayedMovies,
    String? activeGenre,
    String? searchQuery,
    bool? isLoadingMore,
    bool? hasMore,
    Movie? selectedMovie,
    int? limit,
    int? offset,
  }) {
    return MovieState(
      allMovies: allMovies ?? this.allMovies,
      displayedMovies: displayedMovies ?? this.displayedMovies,
      activeGenre: activeGenre ?? this.activeGenre,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  factory MovieState.initial(List<Movie> allMovies, {int limit = 5}) {
    return MovieState(
      allMovies: allMovies,
      displayedMovies: [],
      activeGenre: null,
      searchQuery: '',
      isLoadingMore: false,
      hasMore: true,
      selectedMovie: null,
      limit: limit,
      offset: 0,
    );
  }
}

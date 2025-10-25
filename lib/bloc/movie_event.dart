// lib/bloc/movie_event.dart
abstract class MovieEvent {}

class InitializeMovies extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;
  SearchMovies(this.query);
}

class FilterByGenre extends MovieEvent {
  final String? genre;
  FilterByGenre(this.genre);
}

class LoadMoreMovies extends MovieEvent {}

class SelectMovie extends MovieEvent {
  final int movieId;
  SelectMovie(this.movieId);
}

class ToggleFavorite extends MovieEvent {
  final int movieId;
  ToggleFavorite(this.movieId);
}

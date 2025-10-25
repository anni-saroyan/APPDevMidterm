// lib/bloc/movie_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/movie_model.dart';
import 'movie_event.dart';
import 'movie_state.dart';
import '../data/sample_movies.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieState.initial(sampleMovies, limit: 5)) {
    on<InitializeMovies>(_onInitialize);
    on<SearchMovies>(_onSearch);
    on<FilterByGenre>(_onFilter);
    on<LoadMoreMovies>(_onLoadMore);
    on<SelectMovie>(_onSelectMovie);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  void _onInitialize(InitializeMovies event, Emitter<MovieState> emit) {
    final list = _applyFilters(state.allMovies);
    emit(state.copyWith(
      displayedMovies: list.take(state.limit).toList(),
      offset: state.limit,
      hasMore: list.length > state.limit,
    ));
  }

  void _onSearch(SearchMovies event, Emitter<MovieState> emit) {
    final filtered = _applyFilters(state.allMovies,
        search: event.query, genre: state.activeGenre);
    emit(state.copyWith(
      searchQuery: event.query,
      displayedMovies: filtered.take(state.limit).toList(),
      offset: state.limit,
      hasMore: filtered.length > state.limit,
    ));
  }

  void _onFilter(FilterByGenre event, Emitter<MovieState> emit) {
    final filtered = _applyFilters(state.allMovies,
        search: state.searchQuery, genre: event.genre);
    emit(state.copyWith(
      activeGenre: event.genre,
      displayedMovies: filtered.take(state.limit).toList(),
      offset: state.limit,
      hasMore: filtered.length > state.limit,
    ));
  }

  Future<void> _onLoadMore(
      LoadMoreMovies event, Emitter<MovieState> emit) async {
    if (state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true));

    await Future.delayed(const Duration(milliseconds: 300));

    final filtered = _applyFilters(state.allMovies,
        search: state.searchQuery, genre: state.activeGenre);
    final next = filtered.skip(state.offset).take(state.limit).toList();

    emit(state.copyWith(
      displayedMovies: [...state.displayedMovies, ...next],
      offset: state.offset + next.length,
      hasMore: state.offset + next.length < filtered.length,
      isLoadingMore: false,
    ));
  }

  void _onSelectMovie(SelectMovie event, Emitter<MovieState> emit) {
    final movie =
    state.allMovies.firstWhere((m) => m.id == event.movieId);
    emit(state.copyWith(selectedMovie: movie));
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<MovieState> emit) {
    final updatedAll = state.allMovies.map((m) {
      if (m.id == event.movieId) {
        return m.copyWith(isFavorite: !m.isFavorite);
      }
      return m;
    }).toList();

    final updatedDisplayed = state.displayedMovies.map((m) {
      if (m.id == event.movieId) {
        return m.copyWith(isFavorite: !m.isFavorite);
      }
      return m;
    }).toList();

    final updatedSelected = state.selectedMovie?.id == event.movieId
        ? state.selectedMovie!.copyWith(isFavorite: !state.selectedMovie!.isFavorite)
        : state.selectedMovie;

    emit(state.copyWith(
      allMovies: updatedAll,
      displayedMovies: updatedDisplayed,
      selectedMovie: updatedSelected,
    ));
  }

  List<Movie> _applyFilters(List<Movie> movies,
      {String search = '', String? genre}) {
    final q = search.toLowerCase();
    return movies.where((m) {
      final matchesGenre = genre == null || genre.isEmpty || m.genre == genre;
      final matchesSearch = q.isEmpty || m.title.toLowerCase().contains(q);
      return matchesGenre && matchesSearch;
    }).toList();
  }
}

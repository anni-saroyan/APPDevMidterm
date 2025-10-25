// lib/data/sample_movies.dart
import '../models/movie_model.dart';

final List<Movie> sampleMovies = List.generate(20, (i) {
  final genres = ['Action', 'Drama', 'Comedy', 'Horror'];
  final genre = genres[i % genres.length];
  return Movie(
    id: i + 1,
    title: 'Movie #${i + 1}',
    genre: genre,
    description:
    'This is a description for Movie #${i + 1}, an awesome $genre film.',
    director: 'Director ${String.fromCharCode(65 + (i % 26))}',
    year: 2000 + (i % 24),
  );
});

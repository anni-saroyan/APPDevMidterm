// lib/models/movie_model.dart
class Movie {
  final int id;
  final String title;
  final String genre;
  final String description;
  final String director;
  final int year;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.description,
    required this.director,
    required this.year,
    this.isFavorite = false,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? genre,
    String? description,
    String? director,
    int? year,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      director: director ?? this.director,
      year: year ?? this.year,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

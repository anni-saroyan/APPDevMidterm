// lib/pages/movie_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_state.dart';
import '../bloc/movie_event.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        final movie = state.selectedMovie;
        if (movie == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Movie Details')),
            body: const Center(child: Text('No movie selected.')),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(movie.title),
            actions: [
              IconButton(
                icon: Icon(
                    movie.isFavorite ? Icons.star : Icons.star_border),
                onPressed: () => context
                    .read<MovieBloc>()
                    .add(ToggleFavorite(movie.id)),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                Text('Genre: ${movie.genre}'),
                Text('Director: ${movie.director}'),
                Text('Year: ${movie.year}'),
                const SizedBox(height: 12),
                Text(movie.description),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

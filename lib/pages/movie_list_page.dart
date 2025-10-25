// lib/pages/movie_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import 'movie_details_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(InitializeMovies());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 250) {
      context.read<MovieBloc>().add(LoadMoreMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Explorer')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by movie title...',
              ),
              onChanged: (v) =>
                  context.read<MovieBloc>().add(SearchMovies(v)),
            ),
            const SizedBox(height: 8),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                final genres =
                state.allMovies.map((m) => m.genre).toSet().toList();
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: const Text('All'),
                        selected: state.activeGenre == null,
                        onSelected: (_) =>
                            context.read<MovieBloc>().add(FilterByGenre(null)),
                      ),
                      const SizedBox(width: 8),
                      ...genres.map((g) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(g),
                          selected: state.activeGenre == g,
                          onSelected: (_) => context
                              .read<MovieBloc>()
                              .add(FilterByGenre(g)),
                        ),
                      )),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state.displayedMovies.isEmpty) {
                    return const Center(child: Text('No movies found.'));
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.displayedMovies.length +
                        (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.displayedMovies.length) {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ));
                      }
                      final movie = state.displayedMovies[index];
                      return ListTile(
                        title: Text(movie.title),
                        subtitle: Text('${movie.genre} • ${movie.year}'),
                        trailing: IconButton(
                          icon: Icon(movie.isFavorite
                              ? Icons.star
                              : Icons.star_border),
                          onPressed: () => context
                              .read<MovieBloc>()
                              .add(ToggleFavorite(movie.id)),
                        ),
                        onTap: () {
                          context
                              .read<MovieBloc>()
                              .add(SelectMovie(movie.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MovieDetailsPage()),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/movie_bloc.dart';
import 'pages/movie_list_page.dart';

void main() {
  runApp(const MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  const MovieExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieBloc(),
      child: MaterialApp(
        title: 'Movie Explorer',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MovieListPage(),
      ),
    );
  }
}

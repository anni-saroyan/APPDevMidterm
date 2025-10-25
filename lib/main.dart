import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/movie_bloc.dart.dart';
import 'pages/movie_list_page.dart.dart';
void main() {
  runApp(
    BlocProvider(
      create: (_) => MovieBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MoviePage(),
      ),
    ),
  );
}
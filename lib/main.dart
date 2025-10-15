import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/Homework_bloc.dart';
import 'Pages/HomeworkListPage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeworkBloc(),
      child: const HomeworkApp(),
    ),
  );
}

class HomeworkApp extends StatelessWidget {
  const HomeworkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework Manager',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeworkListPage(),
    );
  }
}

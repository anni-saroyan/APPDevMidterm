import 'package:flutter/material.dart';
import '../Entities/Homework.dart';

class HomeworkBloc extends ChangeNotifier {
  final List<Homework> _homeworks = [];

  List<Homework> get homeworks => List.unmodifiable(_homeworks);

  void addHomework(Homework homework) {
    _homeworks.add(homework);
    notifyListeners();
  }

  void toggleCompletion(int index) {
    _homeworks[index].isDone = !_homeworks[index].isDone;
    notifyListeners();
  }
}

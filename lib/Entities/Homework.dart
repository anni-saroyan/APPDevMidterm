class Homework {
  String subjectName;
  String title;
  DateTime dueDate;
  bool isDone;
  Homework({
    required this.subjectName,
    required this.title,
    required this.dueDate,
    this.isDone = false,
  });
}

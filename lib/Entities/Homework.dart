class Homework {
  String subject;
  String title;
  DateTime dueDate;
  bool isDone;
  Homework({
    required this.subject,
    required this.title,
    required this.dueDate,
    this.isDone = false,
  });
}

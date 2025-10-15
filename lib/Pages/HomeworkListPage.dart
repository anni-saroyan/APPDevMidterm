import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/Homework_bloc.dart';
import 'AddHomeworkPage.dart';

class HomeworkListPage extends StatelessWidget {
  const HomeworkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeworkBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework Manager'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bloc.homeworks.length,
        itemBuilder: (context, index) {
          final hw = bloc.homeworks[index];
          return ListTile(
            title: Text(
              hw.title,
              style: TextStyle(
                decoration: hw.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
                "${hw.subject} - Due: ${hw.dueDate.toLocal().toString().split(' ')[0]}"),
            trailing: Checkbox(
              value: hw.isDone,
              onChanged: (_) => bloc.toggleCompletion(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddHomeworkPage()),
          );
        },
      ),
    );
  }
}

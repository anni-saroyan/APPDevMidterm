import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/Homework_bloc.dart';
import '../Entities/Homework.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({super.key});

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeworkBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Homework')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) =>
                value!.isEmpty ? 'Enter subject' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value!.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No date chosen'
                      : 'Due: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                  const Spacer(),
                  ElevatedButton(
                    child: const Text('Pick Date'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Add Homework'),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null) {
                    bloc.addHomework(
                      Homework(
                        subject: _subjectController.text,
                        title: _titleController.text,
                        dueDate: _selectedDate!,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

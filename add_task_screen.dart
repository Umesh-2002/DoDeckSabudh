// lib/screens/add_task_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? existingTask;

  const AddTaskScreen({Key? key, this.existingTask}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _pickedDate;
  late String _status;

  TimeOfDay _startTime = TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 12, minute: 0);

  final List<String> _statuses = ['Not Started', 'In Progress', 'Completed'];

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      final t = widget.existingTask!;
      _titleController = TextEditingController(text: t.title);
      _descriptionController = TextEditingController(text: t.description);
      _pickedDate = t.dueDate;
      _startTime = t.startTime;
      _endTime = t.endTime;
      _status = t.status;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _pickedDate = DateTime.now().add(Duration(days: 1));
      _status = _statuses.first;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> picktheDate() async {
    final dt = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (dt != null) setState(() => _pickedDate = dt);
  }

  Future<void> picktheStartTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (t != null) setState(() => _startTime = t);
  }

  Future<void> picktheEndTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (t != null) setState(() => _endTime = t);
  }

  void save_Task() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: widget.existingTask?.id ?? DateTime.now().toIso8601String(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        dueDate: _pickedDate,
        startTime: _startTime,
        endTime: _endTime,
        status: _status,
        isCompleted: _status == 'Completed',
      );
      Navigator.of(context).pop(newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (val) =>
                val == null || val.trim().isEmpty ? 'Enter title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Enter description'
                    : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Due: ${DateFormat.yMMMd().format(_pickedDate)}'),
                  Spacer(),
                  TextButton(onPressed: picktheDate, child: Text('Pick Date')),
                ],
              ),
              Row(
                children: [
                  Text('From: ${_startTime.format(context)}'),
                  Spacer(),
                  TextButton(
                      onPressed: picktheStartTime, child: Text('Pick Start')),
                ],
              ),
              Row(
                children: [
                  Text('To: ${_endTime.format(context)}'),
                  Spacer(),
                  TextButton(
                      onPressed: picktheEndTime, child: Text('Pick End')),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: 'Status'),
                items: _statuses
                    .map((s) =>
                    DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _status = val);
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: save_Task,
                child: Text(isEditing ? 'Update Task' : 'Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

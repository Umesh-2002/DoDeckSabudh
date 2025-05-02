// lib/screens/task_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  // Null-safe constructor with Key and super:
  const TaskDetailScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontSize: 24,                // text size
                fontWeight: FontWeight.bold, // bold
                color: Colors.deepPurple,    // color
              ),

            ),
            SizedBox(height: 10),
            Text('Description: ${task.description}'),
            SizedBox(height: 10),
            Text(
              'Time: ${task.startTime.format(context)} - ${task.endTime.format(context)}',
            ),
            SizedBox(height:10),
            Text(
              'Due: ${DateFormat.yMMMd().format(task.dueDate)}',
            ),
            SizedBox(height: 10),
            Text('Status: ${task.status}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

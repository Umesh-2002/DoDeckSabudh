// lib/widgets/task_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const TaskCard({
    required this.task,
    this.onToggle,
    this.onDelete,
    this.onTap,
  }) ;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();

    // Exact deadline combines date + time
    final deadline = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
      task.endTime.hour,
      task.endTime.minute,
    );

    final isOverdue = deadline.isBefore(now);

    // Theme-based backgrounds
    final normalBg = theme.colorScheme.surfaceVariant;
    final overdueBg = theme.colorScheme.error.withOpacity(0.2);
    final background = isOverdue ? overdueBg : normalBg;

    // Debug log
    // print('Task "${task.title}" bg: $background');

    return Card(
      color: background,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: IconButton(
          icon: Icon(
            task.isCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: onToggle,
        ),
        title: Text(
          task.title,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        subtitle: Text(
          '${task.description}\n'
              'Due: ${DateFormat.yMMMd().format(task.dueDate)}\n'
              'Time: ${task.startTime.format(context)} - ${task.endTime.format(context)}',
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.onSurface),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

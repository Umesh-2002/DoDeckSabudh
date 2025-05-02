// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import 'add_task_screen.dart';
import 'settings_screen.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Choose Theme'),
        content: Consumer<ThemeProvider>(
          builder: (_, themeProv, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: Text('Light Theme'),
                value: false,
                groupValue: themeProv.isDark,
                onChanged: (v) {
                  if (v != null) themeProv.setDarkMode(v);
                  Navigator.of(ctx).pop();
                },
              ),
              RadioListTile<bool>(
                title: Text('Dark Theme'),
                value: true,
                groupValue: themeProv.isDark,
                onChanged: (v) {
                  if (v != null) themeProv.setDarkMode(v);
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openAddEditScreen({Task? existing}) async {
    final result = await Navigator.of(context).push<Task>(
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(existingTask: existing),
      ),
    );
    if (result != null) {
      Provider.of<TaskProvider>(context, listen: false).addOrUpdate(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TaskProvider>(context);
    final tasks = prov.tasks;
    final now = DateTime.now();

    // initialize sections
    final sections = <String, List<Task>>{
      'Overdue': [],
      'Not Started': [],
      'In Progress': [],
      'Completed': [],
    };

    // MODIFIED LOOP
    for (var t in tasks) {
      final deadline = DateTime(
        t.dueDate.year,
        t.dueDate.month,
        t.dueDate.day,
        t.endTime.hour,
        t.endTime.minute,
      );

      //  Only non-completed tasks can go to Overdue
      if (!(t.isCompleted || t.status.toLowerCase() == 'completed')
          && deadline.isBefore(now)) {
        sections['Overdue']!.add(t);

        //  Completed section
      } else if (t.isCompleted || t.status.toLowerCase() == 'completed') {
        sections['Completed']!.add(t);

        //  In Progress section
      } else if (t.status.toLowerCase() == 'in progress') {
        sections['In Progress']!.add(t);

        //  Not Started section
      } else {
        sections['Not Started']!.add(t);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('DoDeck Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            tooltip: 'Change Theme',
            onPressed: _showThemeDialog,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks yet. Tap + to add one.'))
          : ListView(
        children: sections.entries
            .where((e) => e.value.isNotEmpty)
            .map((entry) {
          return _buildSection(entry.key, entry.value, prov);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddEditScreen(),
      ),
    );
  }

  Widget _buildSection(
      String title, List<Task> list, TaskProvider prov) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...list.map((t) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: TaskCard(
                task: t,
                onTap: () => _openAddEditScreen(existing: t),

                // MODIFIED onToggle
                onToggle: () {
                  // only allow "In Progress" → Completed
                  if (t.status.toLowerCase() == 'in progress') {
                    prov.addOrUpdate(Task(
                      id: t.id,
                      title: t.title,
                      description: t.description,
                      dueDate: t.dueDate,
                      startTime: t.startTime,
                      endTime: t.endTime,
                      isCompleted: true,
                      status: 'Completed',
                    ));
                  }
                },

                onDelete: () => prov.delete(t.id),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

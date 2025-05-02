// lib/providers/task_provider.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/db_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => [..._tasks];

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks = await DBHelper.instance.fetchTasks();
    notifyListeners();
  }

  Future<void> addOrUpdate(Task t) async {
    final idx = _tasks.indexWhere((e) => e.id == t.id);
    if (idx >= 0) {
      _tasks[idx] = t;
      await DBHelper.instance.updateTask(t);
    } else {
      _tasks.add(t);
      await DBHelper.instance.insertTask(t);
    }
    notifyListeners();
  }

  Future<void> delete(String id) async {
    _tasks.removeWhere((e) => e.id == id);
    await DBHelper.instance.deleteTask(id);
    notifyListeners();
  }
}
// lib/models/task.dart

import 'package:flutter/material.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isCompleted;
  String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
    this.status = 'Not Started',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
      'isCompleted': isCompleted ? 1 : 0,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      startTime: TimeOfDay(hour: map['startHour'], minute: map['startMinute']),
      endTime: TimeOfDay(hour: map['endHour'], minute: map['endMinute']),
      isCompleted: map['isCompleted'] == 1,
      status: map['status'],
    );
  }
}

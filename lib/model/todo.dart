import 'package:flutter/material.dart';
import 'dart:math';

final Random random = Random();
const List<String> testTitles = [
  'Review quarterly budget reports',
  'Schedule dentist appointment',
  'Update project documentation',
  'Buy groceries for the week',
  'Call mom for her birthday',
  'Organize desk workspace',
  'Submit expense reimbursement',
  'Prepare presentation slides',
  'Water the plants',
  'Renew car registration',
  'Reply to client emails',
  'Book flight tickets for conference',
  'Clean out garage',
  'Schedule team meeting',
  'Pay utility bills',
  'Update resume and portfolio',
  'Research vacation destinations',
  'Fix leaky kitchen faucet',
  'Review and sign contract',
  'Backup computer files',
  'Order new office supplies',
  'Complete online training course',
  'Plan weekly meal prep',
  'Change air filter in HVAC',
  'Donate old clothes to charity'
];

enum TaskPriority {high, normal, low}

class Todo {
  final String title;
  final IconData icon;
  TaskPriority priority;
  DateTime dateAdded;
  bool completed;
  DateTime? dateCompleted;

  static const List<IconData> iconList = [
    Icons.work,
    Icons.shopping_bag,
    Icons.school,
    Icons.book,
    Icons.home,
    Icons.pets,
    Icons.tv,
    Icons.cleaning_services,
    Icons.airplane_ticket,
    Icons.sports,
  ];
  static const Map<TaskPriority, IconData> priorityIcon = {
    TaskPriority.low : Icons.arrow_drop_down,
    TaskPriority.normal : Icons.commit,
    TaskPriority.high : Icons.arrow_drop_up,
  };

  Todo({required this.title, required this.icon, priority})
    : priority = priority ?? 0.5,
      dateAdded = DateTime.now(),
      completed = false;
  Todo.demoData()
    : title = testTitles[random.nextInt(testTitles.length)],
      icon = iconList[random.nextInt(iconList.length)],
      priority = TaskPriority.values[random.nextInt(TaskPriority.values.length)],
      dateAdded = DateTime.now(),
      completed = false;
    Todo.demoDataWithPriority({required this.priority})
    : title = testTitles[random.nextInt(testTitles.length)],
      icon = iconList[random.nextInt(iconList.length)],
      dateAdded = DateTime.now(),
      completed = false;

  void updateComplete(bool complete){
    completed = complete;
    dateCompleted = complete ? DateTime.now() : null;
  }
}

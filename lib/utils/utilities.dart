import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class Utilities {
  static bool get isIOS{
    if (kIsWeb){
      return false;
    }
    else{
      return Platform.isIOS;
    }
  }

  static List<Todo> generateTestData(int count){
    return [
      for (int i = 0; i < count; i++)
        Todo.demoData()
    ];
  }

  static List<Todo> generateDemoData(){
    return [
      Todo(title: 'Buy more dog food', priority: TaskPriority.high, icon: Icons.pets),
      Todo(title: 'Finish Homework', priority: TaskPriority.normal, icon: Icons.school),
      Todo(title: 'Workout', priority: TaskPriority.low, icon: Icons.sports),
    ];
  }
}
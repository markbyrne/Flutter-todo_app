import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/utilities.dart';
import 'package:todo_app/views/add_task_modal/add_task_modal.dart';
import 'package:todo_app/widget/todo_list/todo_list.dart';

class MainView extends StatefulWidget {
  final todos = Constants.kTesting ? Utilities.generateTestData(12) : Utilities.generateDemoData();

  MainView({super.key});

  @override
  State<MainView> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  void addTask(Todo task){
    setState(() {
      widget.todos.add(task);
    });
  }

  void openAddTaskModal() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) {
        return AddTaskModal(onSubmit: addTask,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(Constants.kAppName),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: openAddTaskModal),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TodoList(todos: widget.todos),
      ),
    );
  }
}

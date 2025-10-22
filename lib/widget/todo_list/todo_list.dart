import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widget/todo_list/todo_item.dart';

enum SortBy { date, priority }

class TodoList extends StatefulWidget {
  final List<Todo> todos;

  TodoList({super.key, todos}) : todos = todos ?? [];

  List<Todo> get sortedActiveTodos {
    var activeTodos = todos.where((item) => !item.completed).toList();

    activeTodos.sort((a, b) => a.priority.index.compareTo(b.priority.index));

    return activeTodos;
  }

  List<Todo> get sortedCompletedTodos {
    var completedTodos = todos.where((item) => item.completed).toList();

    completedTodos.sort((a, b) => b.dateCompleted!.compareTo(a.dateCompleted!));

    return completedTodos;
  }

  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  void updateList() {
    setState(() {});
  }

  void raiseItemDeletedAlert(Todo todoItem, int idx) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              widget.todos.insert(idx, todoItem);
            });
          },
        ),
      ),
    );
  }

  void removeTodo(Todo todoItem) {
    int todoIndex = widget.todos.indexOf(todoItem);
    setState(() {
      widget.todos.remove(todoItem);
    });
    raiseItemDeletedAlert(todoItem, todoIndex);
  }

  @override
  Widget build(BuildContext context) {
    final activeTodos = widget.sortedActiveTodos;
    final completedTodos = widget.sortedCompletedTodos;

    return widget.todos.isEmpty
        ? Center(
            child: Text(
              Constants.kDefaultEmptyTodosMessage,
              textAlign: TextAlign.center,
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: activeTodos.length,
                  itemBuilder: (ctx, i) {
                    return TodoItem(
                      todoData: activeTodos[i],
                      onUpdate: updateList,
                      onRemove: removeTodo,
                    );
                  },
                ),
              ),

              if (completedTodos.isNotEmpty) Divider(),

              if (completedTodos.isNotEmpty)
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.30,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: completedTodos.length,
                    itemBuilder: (ctx, i) {
                      return TodoItem(
                        todoData: completedTodos[i],
                        onUpdate: updateList,
                        onRemove: removeTodo,
                      );
                    },
                  ),
                ),
            ],
          );
  }
}

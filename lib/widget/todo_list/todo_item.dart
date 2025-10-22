import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todoData;
  final void Function() onUpdate;
  final void Function(Todo) onRemove;

  const TodoItem({super.key, required this.todoData, required this.onUpdate, required this.onRemove});

  @override
  State<StatefulWidget> createState() {
    return _TodoItemState();
  }
}

class _TodoItemState extends State<TodoItem> {
  bool editPriority = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todoData.dateAdded),
      onDismissed: (direction) {
        widget.onRemove(widget.todoData);
      },
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        child: Center(
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ),
      child: Card(
        color: widget.todoData.completed
        ? Theme.of(context).colorScheme.surfaceContainerHigh
        : Theme.of(context).colorScheme.secondaryContainer,
        child: Row(
          children: [
            Checkbox.adaptive(
              value: widget.todoData.completed,
              onChanged: (value) {
                setState(() {
                  widget.todoData.updateComplete(value ?? false);
                  widget.onUpdate();
                });
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    widget.todoData.icon,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.todoData.title,
                      style: TextStyle().copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            editPriority
            ? Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.todoData.priority = TaskPriority.low;
                    setState(() {
                      editPriority = false;
                      widget.onUpdate();
                    });
                  },
                  icon: Icon(Todo.priorityIcon[TaskPriority.low]),
                ),
                IconButton(
                  onPressed: () {
                    widget.todoData.priority = TaskPriority.normal;
                    setState(() {
                      editPriority = false;
                      widget.onUpdate();
                    });
                  },
                  icon: Icon(Todo.priorityIcon[TaskPriority.normal]),
                ),
                IconButton(
                  onPressed: () {
                    widget.todoData.priority = TaskPriority.high;
                    setState(() {
                      editPriority = false;
                      widget.onUpdate();
                    });
                  },
                  icon: Icon(Todo.priorityIcon[TaskPriority.high]),
                ),
              ],)
            : Visibility(
              visible: !widget.todoData.completed,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    editPriority = true;
                  });
                },
                icon: Icon(Todo.priorityIcon[widget.todoData.priority]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class PrioritySelectField extends StatefulWidget {
  final Function(TaskPriority) onPriorityChanged;
  final TaskPriority initialPriority;

  const PrioritySelectField({super.key, required this.initialPriority, required this.onPriorityChanged});

  @override
  State<PrioritySelectField> createState() {
    return _PrioritySelectFieldState();
  }
}

class _PrioritySelectFieldState extends State<PrioritySelectField> {
  late TaskPriority selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedPriority,
      underline: SizedBox.shrink(),
      icon: SizedBox.shrink(),
      items: TaskPriority.values
          .map(
            (priority) => DropdownMenuItem(
              value: priority,
              child: Icon(Todo.priorityIcon[priority]),
            ),
          )
          .toList(),
      onChanged: (selection) {
        setState(() {
          selectedPriority = selection ?? TaskPriority.normal;
          widget.onPriorityChanged(selectedPriority);
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return TaskPriority.values.map((priority) {
          return Icon(Todo.priorityIcon[priority]);
        }).toList();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/views/add_task_modal/icon_select_field.dart';
import 'package:todo_app/views/add_task_modal/priority_select_field.dart';

class AddTaskModal extends StatefulWidget {
  final void Function(Todo task) onSubmit;

  const AddTaskModal({super.key, required this.onSubmit});

  @override
  State<AddTaskModal> createState() {
    return _AddTaskModalState();
  }
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _titleController = TextEditingController();
  IconData _selectedIcon = Todo.iconList[0];
  TaskPriority _selectedPriority = TaskPriority.normal;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void updateSelectedPriority(TaskPriority selectedPriority) {
    _selectedPriority = selectedPriority;
  }

  void updateSelectedIcon(IconData selectedIcon) {
    _selectedIcon = selectedIcon;
  }

  void submit() {
    List<String> errorMsgs = [];
    final trimmedTitle = _titleController.text.trim();

    if (trimmedTitle.isEmpty) {
      errorMsgs.add('Task Name cannot be blank.');
    }

    if (errorMsgs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: Text(errorMsgs.join('\n')),
            actions: [
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      widget.onSubmit(
        Todo(
          title: _titleController.text,
          icon: _selectedIcon,
          priority: _selectedPriority,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.tertiary,),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconSelectField(
                  initialIcon: _selectedIcon,
                  onIconChanged: updateSelectedIcon,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('Task Name')),
                  ),
                ),
                SizedBox(width: 16),
                PrioritySelectField(
                  initialPriority: _selectedPriority,
                  onPriorityChanged: updateSelectedPriority,
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: submit,
                  child: const Text('Save Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

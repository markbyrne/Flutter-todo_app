import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class IconSelectField extends StatefulWidget {
  final IconData initialIcon;
  final Function(IconData) onIconChanged;

  const IconSelectField({super.key, required this.initialIcon, required this.onIconChanged});

  @override
  State<IconSelectField> createState() {
    return _IconSelectFieldState();
  }
}

class _IconSelectFieldState extends State<IconSelectField> {
  late IconData selectedIcon;

  @override
  void initState() {
    super.initState();
    selectedIcon = widget.initialIcon;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedIcon,
      underline: SizedBox.shrink(),
      icon: SizedBox.shrink(),
      items: Todo.iconList
          .map(
            (iconData) =>
                DropdownMenuItem(value: iconData, child: Icon(iconData)),
          )
          .toList(),
      onChanged: (selection) {
        setState(() {
          selectedIcon = selection ?? Todo.iconList[0];
          widget.onIconChanged(selectedIcon);
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return Todo.iconList.map((iconData) {
          return Icon(iconData);
        }).toList();
      },
    );
  }
}

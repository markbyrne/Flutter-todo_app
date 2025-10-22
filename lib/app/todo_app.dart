import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/themes/main_theme.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/views/main_view.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: Constants.kAppName,
      theme: MainTheme.light,
      darkTheme: MainTheme.dark,
      themeMode: ThemeMode.system,
      home: MainView(),
    );
  }
}

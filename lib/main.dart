import 'package:flutter/material.dart';
import 'package:to_do_app/pages/to_do_page.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TO DO APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
          useMaterial3: true,
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 20)),
        ),
        home: const ToDoPage());
  }
}

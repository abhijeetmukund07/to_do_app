import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog.adaptive(
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
            fillColor: Colors.green,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
      ),
    );
  }
}

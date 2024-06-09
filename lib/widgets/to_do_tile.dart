import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  final Function(bool?)? onChanged;

  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskStatus,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.yellow[400],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Checkbox(
            value: taskStatus,
            onChanged: onChanged,
            activeColor: const Color.fromRGBO(89, 227, 255, 1),
            splashRadius: 25,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          Text(taskName,
              style: taskStatus
                  ? const TextStyle(
                      decoration: TextDecoration.lineThrough, fontSize: 22)
                  : const TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}

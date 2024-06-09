import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/add_task.dart';
import 'package:to_do_app/widgets/add_task_bottom_sheet.dart';
import 'package:to_do_app/widgets/to_do_tile.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List tasks = [
    ['Learn Flutter', false],
    ['Learn Firebase', false],
    ['Build a ToDo App', false],
  ];

  void toggleTaskStatus(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
  }

  void addNewTask() {
    tasks.add(['Learn Flutter', false]);
  }

  void createNewTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This makes sure the sheet is resized when the keyboard is shown
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // This ensures the bottom padding is enough for the keyboard
            ),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: addNewTask, icon: const Icon(Icons.add))),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'T O  D O',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
      ),
      backgroundColor: Colors.yellow[200],
      body: SafeArea(
          child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: tasks[index][0],
              taskStatus: tasks[index][1],
              onChanged: (value) => toggleTaskStatus(value, index));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

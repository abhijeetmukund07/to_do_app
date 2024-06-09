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

  int completedTasksCount = 0;

  void toggleTaskStatus(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
      if (value == true) {
        completedTasksCount++;
      } else {
        completedTasksCount--; //*** else accounts for false when clicked on checkbox or slid left to right which gives value as null
      }
    });
  }

  void _addNewTask() {
    setState(() {
      tasks.add(['Learn Flutter', false]);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      completedTasksCount--; // ***** Might need a review ****
    });
  }

  void showAddNewTaskTextField() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0))),
      context: context,
      isScrollControlled:
          true, // This makes sure the sheet is resized when the keyboard is shown
      builder: (context) {
        return Container(
          height: 45,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 7, 15, 15),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: _addNewTask,
                        icon: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Icon(
                            Icons.add,
                            // weight: 15,
                            size: 25,
                          ),
                        )),
                    fillColor: Colors.amberAccent,
                    border: InputBorder.none),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
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
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => {
              if (direction == DismissDirection.startToEnd)
                {toggleTaskStatus(null, index)}
              else if (direction == DismissDirection.endToStart)
                {deleteTask(index)}
            },
            child: ToDoTile(
                taskName: tasks[index][0],
                taskStatus: tasks[index][1],
                onChanged: (value) => toggleTaskStatus(value, index)),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddNewTaskTextField,
        child: const Icon(Icons.add),
      ),
    );
  }
}

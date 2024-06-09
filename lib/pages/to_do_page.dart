import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/add_task.dart';
import 'package:to_do_app/widgets/add_task_bottom_sheet.dart';
import 'package:to_do_app/widgets/to_do_tile.dart';

// class ToDoPage extends StatefulWidget {
//   const ToDoPage({super.key});

//   @override
//   State<ToDoPage> createState() => _ToDoPageState();
// }

// class _ToDoPageState extends State<ToDoPage> {
//   List tasks = [
//     ['Learn Flutter', false],
//     ['Learn Firebase', false],
//     ['Build a ToDo App', false],
//   ];

//   List completedTasks = [];
//   int completedTasksCount = 0;

// void toggleTaskStatus(bool? value, int index) {
//   setState(() {
//     tasks[index][1] = !tasks[index][1];
//     if (value == true) {
//       completedTasksCount++;
//       completedTasks.add(tasks[index]);
//     } else {
//       completedTasksCount--; //*** else accounts for false when clicked on checkbox or slid left to right which gives value as null
//       completedTasks.remove(tasks[index]);
//     }
//   });
// }

// void _addNewTask() {
//   setState(() {
//     tasks.add(['Learn Flutter', false]);
//   });
// }

//   void deleteTask(int index) {
//     setState(() {
//       tasks.removeAt(index);
//       completedTasksCount--; // ***** Might need a review ****
//     });
//   }

// void showAddNewTaskTextField() {
//   showModalBottomSheet(
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(0))),
//     context: context,
//     isScrollControlled:
//         true, // This makes sure the sheet is resized when the keyboard is shown
//     builder: (context) {
//       return Container(
//         height: 45,
//         margin:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Expanded(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(15, 7, 15, 15),
//             child: TextField(
//               autofocus: true,
//               decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                       onPressed: _addNewTask,
//                       icon: const Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                         child: Icon(
//                           Icons.add,
//                           // weight: 15,
//                           size: 25,
//                         ),
//                       )),
//                   fillColor: Colors.amberAccent,
//                   border: InputBorder.none),
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'T O  D O',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.yellow[600],
//       ),
//       backgroundColor: Colors.yellow[200],
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: tasks.length,
//           itemBuilder: (context, index) {
//             return Dismissible(
//               key: UniqueKey(),
//               background: Container(
//                 color: Colors.green,
//                 alignment: Alignment.centerLeft,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: const Icon(Icons.check, color: Colors.white),
//               ),
//               secondaryBackground: Container(
//                 color: Colors.red,
//                 alignment: Alignment.centerRight,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: const Icon(Icons.delete, color: Colors.white),
//               ),
//               onDismissed: (direction) => {
//                 if (direction == DismissDirection.startToEnd)
//                   {toggleTaskStatus(null, index)}
//                 else if (direction == DismissDirection.endToStart)
//                   {deleteTask(index)}
//               },
//               child: ToDoTile(
//                   taskName: tasks[index][0],
//                   taskStatus: tasks[index][1],
//                   onChanged: (value) => toggleTaskStatus(value, index)),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showAddNewTaskTextField,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List tasks = [];

  int completedTasksCount = 0;

  List completedTasks = [];
  final GlobalKey<AnimatedListState> pendingListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> completedListKey =
      GlobalKey<AnimatedListState>();

  void markCompleted(bool? value, int index) {
    setState(() {
      tasks[index][1] = true;
      completedTasksCount++;
      completedTasks.add(tasks[index]);
      final completedTask = tasks.removeAt(index);
      completedListKey.currentState?.insertItem(completedTasks.length - 1);
      pendingListKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildItem(context, completedTask, animation, false),
      );
    });
  }

  void markPending(bool? value, int index) {
    setState(() {
      completedTasks[index][1] = false;
      completedTasksCount--;
      List pendingTask = completedTasks.removeAt(index);
      tasks.add(pendingTask);
      pendingListKey.currentState?.insertItem(tasks.length - 1);
      completedListKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildItem(context, pendingTask, animation, true),
      );
    });
  }

  TextEditingController newTaskController = TextEditingController();
  void _addNewTask(String newTask) {
    if (newTask.isEmpty) return;
    setState(() {
      tasks.add([newTask, false]);
      pendingListKey.currentState?.insertItem(tasks.length - 1);
    });
    newTaskController.clear();
    Navigator.pop(context);
  }

  void deleteTask(int index) {
    setState(() {
      final removedTask = tasks.removeAt(index);
      pendingListKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildItem(context, removedTask, animation, false),
      );
    });
  }

  void deleteCompletedTask(int index) {
    setState(() {
      final removedTask = completedTasks.removeAt(index);
      completedListKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildItem(context, removedTask, animation, true),
      );
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
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 12),
              child: TextField(
                maxLines: null,
                controller: newTaskController,
                autofocus: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _addNewTask(newTaskController.text),
                      icon: const Icon(
                        Icons.add,
                        // weight: 15,
                        size: 25,
                      ),
                    ),
                    fillColor: Colors.amberAccent,
                    hintText: "Enter your task here...",
                    // hintStyle: const TextStyle(fontSize: 20),
                    border: InputBorder.none),
                onSubmitted: (value) => _addNewTask(value),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, List<dynamic> task,
      Animation<double> animation, bool isCompleted) {
    return SizeTransition(
      sizeFactor: animation,
      child: isCompleted
          ? ToDoTile.completedTile(
              taskName: task[0],
              taskStatus: task[1],
              onChanged: (value) =>
                  markPending(value, completedTasks.indexOf(task)),
            )
          : ToDoTile.pendingTile(
              taskName: task[0],
              taskStatus: task[1],
              onChanged: (value) => markCompleted(value, tasks.indexOf(task)),
            ),
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
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Pending Tasks',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              // thickness: 0.8,
              color: Colors.yellow[800],
            ),
            Expanded(
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

                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        markCompleted(null, index);
                      } else if (direction == DismissDirection.endToStart) {
                        deleteTask(index);
                      }
                    },
                    //TODO Tile
                    child: ToDoTile.pendingTile(
                      taskName: tasks[index][0],
                      taskStatus: tasks[index][1],
                      onChanged: (value) => markCompleted(value, index),
                    ),
                  );
                },
              ),
            ),
            if (completedTasks.isNotEmpty) ...[
              Divider(
                color: Colors.yellow[800],
              ),
              const Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      dismissThresholds: const {
                        DismissDirection.startToEnd: 0.7
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        deleteCompletedTask(index);
                      },
                      child: ToDoTile.completedTile(
                        taskName: completedTasks[index][0],
                        taskStatus: completedTasks[index][1],
                        onChanged: (value) => markPending(value, index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddNewTaskTextField,
        child: const Icon(Icons.add),
      ),
    );
  }
}

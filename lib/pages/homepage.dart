import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:trial_project/models/dialogBox.dart';
import 'package:trial_project/models/task.dart';
import 'package:trial_project/models/todotile.dart';

class Homepage extends StatefulWidget {
 const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  //reference the hive box
  final _myBox = Hive.box('mybox');

  final _controller = TextEditingController();
  TaskDatabase db = TaskDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createnewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  /* void deletetask(int index){
      setState(() {
        toDoList.removeAt(index);
      });
  }*/

  void deletetask(index) {
    // final taskIndex = toDoList.indexOf(index);
    setState(
      () {
        db.toDoList.removeAt(index);
      },
    );
    db.updateData();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task Deleted'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[400],
        /*action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                toDoList.add(taskIndex);
              },
            );
          },
        ),*/
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Center(
          child: Text(
            'TO DO ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellowAccent,
        onPressed: createnewTask,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.yellow[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) => ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (context) => deletetask(index),
            ),
          ),
        ),
      ),
      //action button
    );
  }
}




/*void deletetask(index) {
    final taskIndex = toDoList.indexAt(taskname);
    setState(
      () {
        toDoList.remove(taskname);
      },
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                toDoList.insert(taskIndex, taskname);
              },
            );
          },
        ),
      ),
    );
  }*/

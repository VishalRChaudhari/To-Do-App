import 'package:hive_flutter/hive_flutter.dart';


class TaskDatabase {

  List toDoList = [];
  final _myBox = Hive.box('mybox');

  //first time ever opening app
  void initialData(){
      toDoList = [
        ["Make Another app",false]
  ];
  }
  //load data
  void loadData(){
     toDoList = _myBox.get("TODOLIST");
  }
  //update data
  void updateData(){
    _myBox.put("TODOLIST",toDoList);
  }
}

import 'package:flutter/material.dart';
import 'package:test_app/main.dart';
import 'package:test_app/model/Task.dart';

abstract class TaskModel extends ChangeNotifier {
  void addTask(title);

  void deleteTask(index);

  void updateTask(title, index);

  List<Task> get tasks;
}

class TaskImpl extends TaskModel {
  List<Task> _tasks = [];

  TaskImpl() {
    Future.delayed(Duration(seconds: 3)).then((_) => getIt.signalReady(this));
  }

  @override
  void addTask(title) {
    _tasks.add(Task(title: title));
    notifyListeners();
  }

  @override
  void updateTask(title, index) {
    _tasks[index].title = title;
    notifyListeners();
  }

  @override
  void deleteTask(index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  @override
  // TODO: implement tasks
  List<Task> get tasks => _tasks;
}

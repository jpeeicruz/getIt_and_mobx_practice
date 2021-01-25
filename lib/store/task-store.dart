import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:test_app/model/Task.dart';

part 'task-store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  void addTask(title) {
    print('ADD TASK');
    this.tasks.add(Task(title: title));
    print(this.tasks.length);
  }

  @action
  void updateTask(title, index) {
    print('Update Task');
    this.tasks[index].title = title;
  }

  @action
  void deleteTask(index) {
    print('delete task');
    this.tasks.removeAt(index);
  }
}

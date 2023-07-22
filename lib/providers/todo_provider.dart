import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:task_management/helpers/database_helper.dart';

import '../model/task_model.dart';

class TodoProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool toggleSwitch = false;
  String filter = 'Show all';

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_tasks);

  Future<void> getAllTask() async {
    _tasks = await DatabaseHelper.instance.getTaskList();
    notifyListeners();
  }

  Future<void> filterTaskList(String val) async {
    filter = val;
   final tasks = await DatabaseHelper.instance.getTaskList();
    if (val == 'Show all') {
      _tasks = tasks;
    } else if (val == 'Completed') {
      _tasks = tasks.where((element) => element.status == 1).toList();
    } else {
      _tasks = tasks.where((element) => element.status == 0).toList();
    }

    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await DatabaseHelper.instance.insertTask(task);
    await getAllTask();
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await getAllTask();
    notifyListeners();
  }

  Future<void> toggleTask(Task task) async {
    Task togle = Task.withId(
        id: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        status: task.status == 0 ? 1 : 0);
    await DatabaseHelper.instance.updateTask(togle);
    await getAllTask();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await DatabaseHelper.instance.deleteTask(task.id!);
    await getAllTask();
    notifyListeners();
  }
}

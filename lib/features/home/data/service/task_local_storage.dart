import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskes/features/home/data/model/taskes_reponse.dart';

class TaskLocalStorage {
  static const _tasksKey = 'tasks';

  // Save tasks to SharedPreferences
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_tasksKey, tasksJson);
  }

  // Retrieve tasks from SharedPreferences
  Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey);
    if (tasksJson != null) {
      return tasksJson.map((taskJson) => TaskModel.fromJson(jsonDecode(taskJson))).toList();
    } else {
      return [];
    }
  }

  // Clear tasks from SharedPreferences (Optional)
  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
  }
}

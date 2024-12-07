import 'package:flutter/foundation.dart';

import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository _repository = TaskRepository.instance;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _repository.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _repository.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
    await loadTasks();
  }
}

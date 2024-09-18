import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- Models ---
class Task {
  final String id;
  final String name;
  final String description;

  Task({required this.id, required this.name, required this.description});

  @override
  String toString() {
    return 'ID: $id, Name: $name, Description: $description';
  }
}

// --- StateNotifier for managing tasks ---
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  // Add a task
  void addTask(String id, String name, String description) {
    state = [...state, Task(id: id, name: name, description: description)];
  }

  // Remove a task
  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

// Create a StateNotifierProvider for the TaskNotifier
final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_service.dart'; // Import the TaskNotifier provider
import 'package:uuid/uuid.dart'; // To generate unique IDs

class TaskManagerScreen extends ConsumerWidget {
  TaskManagerScreen({super.key});

  // Controllers for the input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for task name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
            // Input field for task description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            // Button to add a task
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final description = descriptionController.text;
                if (name.isNotEmpty && description.isNotEmpty) {
                  final id = const Uuid().v4(); // Generate unique ID
                  ref
                      .read(taskNotifierProvider.notifier)
                      .addTask(id, name, description);
                  // Clear input fields
                  nameController.clear();
                  descriptionController.clear();
                }
              },
              child: const Text('Add Task'),
            ),
            const SizedBox(height: 16),
            // Display the list of tasks
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Remove the task by its ID
                        ref
                            .read(taskNotifierProvider.notifier)
                            .removeTask(task.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
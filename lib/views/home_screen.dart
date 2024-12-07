import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_viewmodel.dart';
import 'task_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: FutureBuilder(
        future: taskViewModel.loadTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer<TaskViewModel>(
            builder: (context, taskViewModel, child) {
              final tasks = taskViewModel.tasks;
              return tasks.isEmpty
                  ? const Center(child: Text('No tasks available.'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TaskForm(task: task),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    taskViewModel.deleteTask(task.id!),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskForm()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

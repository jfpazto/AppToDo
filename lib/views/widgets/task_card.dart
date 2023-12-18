import 'package:flutter/material.dart';
import 'Task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  TaskCard({required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: task.color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            title: Text(task .title),
            trailing: Text(task.fecha.toString()),
            onTap: onTap,
          ),                
        ),
      ),
    );
  }
}
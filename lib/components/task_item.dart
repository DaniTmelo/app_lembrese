import 'package:app_lembrese/models/task.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTitleTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const TaskItem({
    super.key,
    required this.task,
    required this.onTitleTap,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    print(task.toMap());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: task.completed
          ? const Color.fromARGB(
              255, 1, 127, 106) // Verde para tarefas concluídas
          : Colors.grey[400], // Cinza para tarefas não concluídas
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTitleTap, // Ação ao tocar no título
              child: Row(
                children: [
                  Icon(
                    task.completed ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    task.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  task.date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onEditTap, // Ação para editar
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onDeleteTap, // Ação para deletar
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

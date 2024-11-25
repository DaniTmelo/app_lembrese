import 'package:flutter/material.dart';
import 'package:app_lembrese/screen/add_task_screen.dart';
import 'package:app_lembrese/screen/edit_task_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/task_list',
    routes: {
      '/task_list': (context) => TaskListScreen(),
      '/add_task': (context) => AddTaskScreen(),
      '/edit_task': (context) => EditTaskScreen(),
    },
  ));
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(title: "Adicionar tarefa", time: "00:00", completed: true),
  ];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Seta branca
        ),
        title: Row(
          children: [
            SizedBox(width: 8),
            Text("Menu", style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor:
            Color.fromARGB(255, 1, 127, 106), // Fundo verde padronizado
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.calendar_today, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 40, color: Color.fromARGB(255, 1, 127, 106)),
                SizedBox(width: 8),
                Text(
                  "Tarefa do Dia",
                  style: TextStyle(
                    fontSize: 22, // Tamanho de fonte reduzido
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 127, 106),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                    onTitleTap: () {
                      Navigator.pushNamed(context, '/add_task');
                    },
                    onEditTap: () {
                      Navigator.pushNamed(context, '/edit_task');
                    },
                    onDeleteTap: () {
                      _removeTask(index);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              // Centraliza o botão
              child: ElevatedButton(
                onPressed: () {
                  // Adiciona uma nova tarefa com dados fictícios
                  _addTask(Task(
                      title: "Nova tarefa", time: "15:00", completed: false));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor:
                      Color.fromARGB(255, 1, 127, 106), // Fundo verde
                ),
                child: Text(
                  "Adicionar Nova Tarefa",
                  style: TextStyle(
                    fontSize: 16, // Tamanho de fonte reduzido
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTitleTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  TaskItem({
    required this.task,
    required this.onTitleTap,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: task.completed
          ? Color.fromARGB(
              255, 1, 127, 106) // Cor verde para tarefas completadas
          : Colors.grey[400], // Cor cinza para tarefas não completadas
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTitleTap, // Redireciona para adicionar tarefa
              child: Row(
                children: [
                  Icon(
                    task.completed ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    task.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Tamanho de fonte reduzido
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  task.time,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Tamanho de fonte reduzido
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: onEditTap, // Redireciona para editar tarefa
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: onDeleteTap, // Exclui a tarefa
                  child: Icon(
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

class Task {
  String title;
  String time;
  bool completed;

  Task({required this.title, required this.time, this.completed = false});
}

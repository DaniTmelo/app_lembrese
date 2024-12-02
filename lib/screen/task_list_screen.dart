import 'package:app_lembrese/components/task_item.dart';
import 'package:app_lembrese/controller/controller_task.dart';
import 'package:app_lembrese/models/task.dart';
import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  final db = DatabaseControllerTask();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Carrega as tarefas ao iniciar
    _searchController
        .addListener(_filterTasks); // Observa mudanças no campo de busca
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Método para carregar tarefas do banco de dados
  Future<void> _loadTasks() async {
    var taskList = await db.getTasks();
    setState(() {
      tasks = taskList.map((taskMap) => Task.fromMap(taskMap)).toList();
      filteredTasks = tasks; // Inicializa a lista filtrada com todas as tarefas
    });
  }

  // Método para filtrar as tarefas
  void _filterTasks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTasks = tasks
          .where((task) =>
              task.title.toLowerCase().contains(query) ||
              (task.description.toLowerCase().contains(query)))
          .toList();
    });
  }

  // Método para adicionar uma tarefa
  Future<void> _addTask() async {
    Navigator.popAndPushNamed(context, '/add_task');
  }

  // Método para remover uma tarefa
  Future<void> _removeTask(int id) async {
    await db.deleteTask(id);
    _loadTasks(); // Atualiza a lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, size: 24, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Tarefas do Dia",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 1, 127, 106),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _addTask,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: const Color.fromARGB(255, 1, 127, 106),
          ),
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              "Adicionar Nova Tarefa",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Busque uma tarefa",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0),
                ),
              ),
              const SizedBox(height: 16),
              filteredTasks.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredTasks.length,
                      padding: const EdgeInsets.only(bottom: 82),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TaskItem(
                          task: filteredTasks[index],
                          onTitleTap: () async {
                            setState(() {
                              filteredTasks[index].completed =
                                  !filteredTasks[index].completed;
                            });
                            await db.updateTask(
                              id: filteredTasks[index].id!,
                              completed: filteredTasks[index].completed ? 1 : 0,
                            );
                          },
                          onEditTap: () {
                            Navigator.popAndPushNamed(
                              context,
                              '/edit_task',
                              arguments: filteredTasks[index],
                            );
                          },
                          onDeleteTap: () {
                            _removeTask(filteredTasks[index].id!);
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Nenhuma tarefa encontrada...",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

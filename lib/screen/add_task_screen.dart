import 'package:app_lembrese/controller/controller_task.dart';
import 'package:app_lembrese/utils/constants.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();
  final controller = DatabaseControllerTask();
  String _selectedTime = "HH : MM";

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
        title: const Text(
          "Tarefa do Dia",
          style: kButtonTextStyle,
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 36),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: kTextColor,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text("DESCREVA SUA TAREFA", style: kTitleTextStyle),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: kBackgroundTealLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  height: 250,
                  child: TextField(
                    controller:
                        _taskController, // Controlador para capturar o texto
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: kHintTextStyle,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Digite sua tarefa aqui...",
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              const Text("DEFINA O HORÁRIO", style: kTitleTextStyle),
              const SizedBox(height: 15),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(_selectedTime, style: kButtonTextStyle),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      await _saveTask(
                          context); // Salvar tarefa ao clicar no botão
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: kPrimaryColor,
                    ),
                    child: const SizedBox(
                      width: 200,
                      child: Text(
                        "Lembrar",
                        textAlign: TextAlign.center,
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
      });
    }
  }

  Future<void> _saveTask(BuildContext context) async {
    final String title = _taskController.text.trim();

    if (title.isEmpty) {
      // Mostra uma mensagem se o título estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, insira uma descrição para a tarefa."),
        ),
      );
      return;
    }
    if (_selectedTime == "HH : MM") {
      // Mostra uma mensagem se o título estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, insira um horário para a tarefa."),
        ),
      );
      return;
    }

    // Salva a tarefa no banco de dados
    try {
      await controller.createTask(title, title, _selectedTime);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tarefa salva com sucesso!"),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao salvar a tarefa")),
      );
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}

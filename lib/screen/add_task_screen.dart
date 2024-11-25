import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Variável para armazenar o horário selecionado
  String _selectedTime = "HH : MM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Cor da seta branca
        ),
        title: Text(
          "Tarefa do Dia",
          style: TextStyle(
            color: Colors.white, // Cor branca
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 1, 127, 106), // Fundo verde
        elevation: 0, // Remove a sombra do AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(255, 1, 127, 106), // Cor do ícone
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(
                  "DESCREVA SUA TAREFA",
                  style: TextStyle(
                    fontSize: 18, // Tamanho de fonte padronizado
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 127, 106), // Cor do texto
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(20), // Bordas mais arredondadas
              ),
              padding: EdgeInsets.all(10),
              height: 150,
              child: TextField(
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(fontSize: 16), // Fonte padronizada
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Digite sua tarefa aqui...",
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "DEFINA O HORÁRIO",
              style: TextStyle(
                fontSize: 18, // Tamanho de fonte padronizado
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106), // Cor do texto
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Container(
                    width: 200, // Largura ajustada
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 127, 106), // Fundo verde padrão
                      borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15), // Altura mantida
                    alignment: Alignment.center,
                    child: Text(
                      _selectedTime, // Exibe o horário selecionado
                      style: TextStyle(
                        fontSize: 18, // Fonte padronizada
                        color: Colors.white, // Texto branco
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Ação ao clicar no botão
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15), // Altura mantida
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                    ),
                    backgroundColor: Color.fromARGB(255, 1, 127, 106), // Fundo verde padrão
                  ),
                  child: SizedBox(
                    width: 200, // Largura ajustada
                    child: Text(
                      "Lembrar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Fonte padronizada
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Texto branco
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Função para selecionar o horário
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        // Atualiza o horário selecionado para exibir
        _selectedTime = picked.format(context);
      });
    }
  }
}

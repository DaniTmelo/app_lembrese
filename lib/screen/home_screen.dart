import 'package:flutter/material.dart';
import 'about_screen.dart'; // Import da tela "Sobre"
import 'login_screen.dart'; // Import da tela "Login"
import 'add_task_screen.dart'; // Import da tela "Adicionar Tarefa"
import 'task_list_screen.dart'; // Import da tela "Lista de Tarefas"
import 'settings_screen.dart'; // Import da tela "Configurações"

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              "Menu",
              style: TextStyle(color: Colors.white), // Cor branca para "Menu"
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 1, 127, 106), // Cor verde para o AppBar
        iconTheme: IconThemeData(color: Colors.white), // Cor branca para o ícone de três linhas
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 1, 127, 106), // Fundo verde do menu lateral
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 127, 106), // Fundo verde do cabeçalho
                ),
                accountName: Text(
                  "Nome do cadastro",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: null, // Remove o email
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Color.fromARGB(255, 1, 127, 106),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "Definir Tarefas",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTaskScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Tarefas do Dia",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskListScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Configurações",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Sobre",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.white), // Linha divisória
              ListTile(
                title: Text(
                  "Sair",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                onTap: () {
                  // Navega para a tela de login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Busque uma tarefa",
                prefixIcon: Icon(Icons.search),
                suffixIcon: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Icon(Icons.calendar_today),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Color.fromARGB(255, 1, 127, 106), // Cor verde do botão
              ),
              child: Text(
                "Tarefas do dia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Escolha uma data para lembrar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 1, 127, 106), // Cor verde no texto
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Icon(
                  Icons.calendar_today,
                  size: 150,
                  color: Color.fromARGB(255, 1, 127, 106), // Cor verde no ícone
                ),
                Text(
                  "Lembre-se",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 127, 106), // Cor verde no texto
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTaskScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 1, 127, 106), // Cor verde do botão
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                "Adicionar tarefas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data selecionada: ${picked.toLocal()}")),
      );
    }
  }
}

import 'package:app_lembrese/controller/controller_user.dart';
import 'package:app_lembrese/utils/constants.dart';
import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'login_screen.dart';
import 'add_task_screen.dart';
import 'task_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userController = ControllerUser();
  String _userName = "Carregando...";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      final user = await _userController.getUserByEmail(widget.userEmail);
      if (user != null) {
        setState(() {
          _userName = user['name'] ?? "Usuário";
        });
      } else {
        setState(() {
          _userName = "Usuário não encontrado";
        });
      }
    } catch (e) {
      setState(() {
        _userName = "Erro ao carregar nome";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Menu", style: kWhiteTextStyle),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          color: kPrimaryColor,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColor),
                accountName: Text(_userName, style: kWhiteTextStyle),
                accountEmail: Text(widget.userEmail, style: kWhiteTextStyle),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: kPrimaryColor),
                ),
              ),
              _buildDrawerItem(
                title: "Definir Tarefas",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                ),
              ),
              _buildDrawerItem(
                title: "Tarefas do Dia",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TaskListScreen()),
                ),
              ),
              _buildDrawerItem(
                title: "Configurações",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingsScreen(userEmail: widget.userEmail),
                  ),
                ),
              ),
              _buildDrawerItem(
                title: "Sobre",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                ),
              ),
              const Divider(color: Colors.white),
              _buildDrawerItem(
                title: "Sair",
                icon: Icons.exit_to_app,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.task_alt, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskListScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: kPrimaryColor,
              ),
              label: const Text(
                "Tarefas do Dia",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Spacer(),
            const Icon(Icons.calendar_today, size: 150, color: kPrimaryColor),
            const Text(
              "Lembre-se",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: kPrimaryColor,
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Adicionar tarefas",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTaskScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    TextStyle? titleStyle,
  }) {
    return ListTile(
      title: Text(title, style: titleStyle ?? kWhiteTextStyle),
      leading: icon != null ? Icon(icon, color: Colors.white) : null,
      onTap: onTap,
    );
  }
}

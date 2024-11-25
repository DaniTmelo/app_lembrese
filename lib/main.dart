import 'package:app_lembrese/screen/add_task_screen.dart';
import 'package:app_lembrese/screen/edit_task_screen.dart';
import 'package:app_lembrese/screen/home_screen.dart';
import 'package:app_lembrese/screen/login_screen.dart';
import 'package:app_lembrese/screen/profile_screen.dart';
import 'package:app_lembrese/screen/recover_screen.dart';
import 'package:app_lembrese/screen/register_screen.dart';
import 'package:app_lembrese/screen/task_list_screen.dart';
import 'package:app_lembrese/screen/settings_screen.dart'; // Importação da tela de configurações
import 'package:flutter/material.dart';

void main() {
  runApp(LembreSeApp());
}

class LembreSeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembre-se',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/add_task': (context) => AddTaskScreen(),
        '/edit_task': (context) => EditTaskScreen(),
        '/task_list': (context) => TaskListScreen(),
        '/settings': (context) =>
            SettingsScreen(), // Adicionando a rota para SettingsScreen
        '/recover': (context) => RecoverScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
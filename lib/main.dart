import 'package:app_lembrese/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lembrese/models/task.dart';
import 'package:app_lembrese/screen/add_task_screen.dart';
import 'package:app_lembrese/screen/edit_task_screen.dart';
import 'package:app_lembrese/screen/home_screen.dart';
import 'package:app_lembrese/screen/login_screen.dart';
import 'package:app_lembrese/screen/profile_screen.dart';
import 'package:app_lembrese/screen/register_screen.dart';
import 'package:app_lembrese/screen/task_list_screen.dart';
import 'package:app_lembrese/screen/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const LembreSeApp(),
    ),
  );
}

class LembreSeApp extends StatelessWidget {
  const LembreSeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Lembre-se',
          theme: themeProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                );
              case '/register':
                return MaterialPageRoute(
                    builder: (context) => const RegisterScreen());
              case '/home':
                final email = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => HomeScreen(userEmail: email));
              case '/add_task':
                return MaterialPageRoute(
                    builder: (context) => const AddTaskScreen());
              case '/edit_task':
                final task = settings.arguments as Task;
                return MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: task),
                );
              case '/task_list':
                return MaterialPageRoute(
                    builder: (context) => const TaskListScreen());
              case '/settings':
                final email = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => SettingsScreen(userEmail: email));
              case '/profile':
                final email = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => ProfileScreen(userEmail: email));
              default:
                return MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                );
            }
          },
        );
      },
    );
  }
}

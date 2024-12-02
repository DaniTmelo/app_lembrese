import 'package:app_lembrese/components/setting_button.dart';
import 'package:app_lembrese/controller/controller_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lembrese/utils/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  final String userEmail;

  const SettingsScreen({
    super.key,
    required this.userEmail,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 127, 106),
        title: const Text(
          'Configurações',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDarkModeToggle(),
            const SizedBox(height: 24),
            SettingsButton(
              text: "Editar Usuário",
              isDarkMode: themeProvider.isDarkMode,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: widget.userEmail,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeToggle() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final controllerTheme = ControllerTheme();

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        side: const BorderSide(
            color: Color.fromARGB(255, 1, 127, 106), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        themeProvider.toggleTheme(); // Alterna o tema
        final isDark = await controllerTheme.isDarkMode();
        if (isDark) {
          await controllerTheme.toggleDarkMode(false);
        } else {
          await controllerTheme.toggleDarkMode(true);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Text(
            themeProvider.isDarkMode ? "Modo Claro" : "Modo Escuro",
            style: TextStyle(
              fontSize: 18,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(); // Alterna o tema
            },
            activeColor: const Color.fromARGB(255, 1, 127, 106),
          ),
        ],
      ),
    );
  }
}

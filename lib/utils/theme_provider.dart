import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners(); // Notifica os widgets para reconstruírem
  }

  ThemeData get currentTheme {
    return isDarkMode
        ? ThemeData.dark()
        : ThemeData(
            primarySwatch: Colors.teal,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
          );
  }
}

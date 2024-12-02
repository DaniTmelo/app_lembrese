import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final bool isDarkMode;
  final VoidCallback onPressed;

  const SettingsButton({
    super.key,
    required this.text,
    required this.isDarkMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        side: const BorderSide(
            color: Color.fromARGB(255, 1, 127, 106), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 127, 106),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}

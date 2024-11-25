import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Importando a tela ProfileScreen

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 127, 106), // Cor verde padronizada
        title: Text(
          'Menu', // Alterando para "Menu"
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Ícone de voltar branco
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título Configurações acima de "Modo Escuro" e "Modo Claro"
            Text(
              "Configurações", // Texto centralizado
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center, // Centralizando o título
            ),
            SizedBox(height: 30), // Adicionando espaço antes de "Modo Escuro" e "Modo Claro"

            // Modo Escuro
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                side: BorderSide(color: Color.fromARGB(255, 1, 127, 106), width: 1.5), // Cor verde padronizada
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Mover o texto mais para a esquerda
                children: [
                  SizedBox(width: 10), // Espaço entre a borda e o texto
                  Text(
                    isDarkMode
                        ? "Modo Claro"
                        : "Modo Escuro", // Muda o texto conforme o tema
                    style: TextStyle(
                      fontSize: 18, // Tamanho de fonte padronizado
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black, // Texto branco se escuro, preto se claro
                    ),
                  ),
                  Spacer(),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                    activeColor: Color.fromARGB(255, 1, 127, 106), // Cor verde padronizada
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Botão Redefinir Senha
            SettingsButton(
              text: "Redefinir senha",
              isDarkMode: isDarkMode,
              onPressed: () {
                Navigator.pushNamed(context, '/profile'); // Navega para a tela de perfil
              },
            ),
            SizedBox(height: 20),

            // Botão Alterar nome de usuário
            SettingsButton(
              text: "Alterar nome de usuário",
              isDarkMode: isDarkMode,
              onPressed: () {
                Navigator.pushNamed(context, '/profile'); // Navega para a tela de perfil
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String text;
  final bool isDarkMode;
  final VoidCallback onPressed;

  const SettingsButton({
    required this.text,
    required this.isDarkMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        side: BorderSide(color: Color.fromARGB(255, 1, 127, 106), width: 1.5), // Cor verde padronizada
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Color.fromARGB(255, 1, 127, 106), // Cor de fundo dos botões, verde padronizada
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18, // Tamanho de fonte padronizado
          color: Colors.white, // Texto branco nos botões
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/settings',
    routes: {
      '/settings': (context) => SettingsScreen(),
      '/profile': (context) => ProfileScreen(), // Adicione a rota para a tela de perfil
    },
  ));
}

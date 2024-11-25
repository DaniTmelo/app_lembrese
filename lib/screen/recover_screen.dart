import 'package:flutter/material.dart';

class RecoverScreen extends StatelessWidget {
  const RecoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo e título do app
            Column(
              children: [
                Image.asset(
                  'assets/logo.png', // Substitua pelo caminho do logo
                  height: 80,
                ),
                SizedBox(height: 10),
                Text(
                  "Esqueceu sua senha?",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 127, 106), // Verde-escuro
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Campo de email
            TextField(
              style: TextStyle(
                color: Colors.white, // Texto branco enquanto digita
              ),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 191, 194, 194),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color.fromARGB(255, 191, 194, 194), // Verde escuro
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 1, 127, 106), // Fundo claro
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Botão "Redefinir senha"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implementar lógica de redefinição de senha
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 191, 194, 194),
                  backgroundColor: Color.fromARGB(255, 1, 127, 106),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Redefinir senha",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Link para voltar ao login
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Retorna para a tela anterior (Login)
              },
              child: Text(
                "Voltar ao login",
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 127, 106),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

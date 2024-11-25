import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true; // Estado para controlar a visibilidade da senha

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
                  "Lembre-se",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(238, 0, 4, 4)), // Verde-escuro
                ),
              ],
            ),
            SizedBox(height: 30),

            // Campo de email
            TextField(
              style: TextStyle(
                color: Colors.white, // Define a cor do texto digitado
              ),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 220, 223, 223)),
                prefixIcon: Icon(Icons.email,
                    color: Color.fromARGB(
                        255, 220, 223, 223)), // Ícone com cor específica
                filled: true,
                fillColor: Color.fromARGB(255, 1, 127, 106), // Fundo claro
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de senha
            TextField(
              style: TextStyle(
                color: Colors.white, // Define a cor do texto digitado
              ),
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(
                        255, 220, 223, 223)), // Cor do label
                prefixIcon: Icon(Icons.lock,
                    color: Color.fromARGB(255, 220, 223, 223)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 220, 223, 223),
                  ),
                  onPressed: () {
                    // Alterna o valor de _obscureText
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 1, 127, 106), // Fundo do campo
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Link "Esqueceu sua senha?"
            TextButton(
              onPressed: () {
                // Navega para a página de recuperação de senha
                Navigator.pushNamed(context, '/recover');
              },
              child: Text(
                "Esqueceu sua senha?",
                style: TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
              ),
            ),

            // Botão de "Entrar"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 220, 223, 223),
                  backgroundColor:
                      Color.fromARGB(255, 1, 127, 106), // Cor do texto do botão "Entrar"
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Entrar", style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 10),

            // Texto "Ou"
            Text("Ou", style: TextStyle(color: Color.fromARGB(255, 1, 127, 106))),
            SizedBox(height: 10),

            // Botão de "Criar Conta"
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 1, 127, 106), // Cor da borda
                  backgroundColor: Color.fromARGB(37, 15, 143, 123),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Crie sua conta", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

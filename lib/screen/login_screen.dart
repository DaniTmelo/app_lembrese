import 'package:app_lembrese/controller/controller_theme.dart';
import 'package:app_lembrese/controller/controller_user.dart';
import 'package:app_lembrese/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = ControllerUser();
  final controllerTheme = ControllerTheme();

  @override
  void initState() {
    super.initState();
    _vetifyTheme();
  }

  Future<void> _vetifyTheme() async {
    try {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final isDark = await controllerTheme.isDarkMode();
      if (isDark) {
        themeProvider.toggleTheme();
      }
    } catch (e) {
      print(e);
    }
  }

  bool _obscureText = true; // Estado para controlar a visibilidade da senha

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage(context, "Por favor, preencha todos os campos.");
      return;
    }

    try {
      final isAuthenticated =
          await _userController.authenticateUser(email, password);
      if (isAuthenticated) {
        _showMessage(
          context,
          "Login realizado com sucesso!",
        );
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: email,
        );
      } else {
        _showMessage(context, "Email ou senha inválidos.");
      }
    } catch (e) {
      _showMessage(context, "Erro ao realizar login: ${e.toString()}");
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 62),
              // Logo e título do app
              themeProvider.isDarkMode
                  ? Image.asset(
                      'lib/assets/logo_principal_dark.png',
                      height: 190,
                    )
                  : Image.asset(
                      'lib/assets/logo_principal.png',
                      height: 190,
                    ),

              const SizedBox(height: 5),
              // Campo de email
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 220, 223, 223)),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 220, 223, 223),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 1, 127, 106),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de senha
              TextField(
                controller: _passwordController,
                style: const TextStyle(
                  color: Colors.white, // Define a cor do texto digitado
                ),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: const TextStyle(
                      color:
                          Color.fromARGB(255, 220, 223, 223)), // Cor do label
                  prefixIcon: const Icon(Icons.lock,
                      color: Color.fromARGB(255, 220, 223, 223)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 220, 223, 223),
                    ),
                    onPressed: () {
                      // Alterna o valor de _obscureText
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  filled: true,
                  fillColor:
                      const Color.fromARGB(255, 1, 127, 106), // Fundo do campo
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Botão de "Entrar"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 220, 223, 223),
                    backgroundColor: const Color.fromARGB(255, 1, 127, 106),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Texto "Ou"
              const Text("Ou",
                  style: TextStyle(color: Color.fromARGB(255, 1, 127, 106))),
              const SizedBox(height: 10),

              // Botão de "Criar Conta"
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 1, 127, 106),
                    backgroundColor: const Color.fromARGB(37, 15, 143, 123),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Crie sua conta",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

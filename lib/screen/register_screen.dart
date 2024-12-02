import 'package:app_lembrese/controller/controller_user.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;

  final _userController = ControllerUser();

  void _registerUser(BuildContext context) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage(context, "Todos os campos são obrigatórios.");
      return;
    }

    if (password != confirmPassword) {
      _showMessage(context, "As senhas não coincidem.");
      return;
    }

    if (!_termsAccepted) {
      _showMessage(context, "Você precisa aceitar os Termos & Privacidade.");
      return;
    }

    try {
      await _userController.createUser(name, email, password);
      _showMessage(context, "Conta criada com sucesso!");
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: email,
      );
    } catch (e) {
      _showMessage(context, "Erro ao criar a conta: ${e.toString()}");
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Partiu!", style: TextStyle(fontSize: 50)),
            Text("Crie sua conta", style: TextStyle(fontSize: 30)),
          ],
        ),
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildTextField(
                controller: _nameController,
                labelText: 'Nome Completo',
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _emailController,
                labelText: 'Endereço de Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Senha',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _confirmPasswordController,
                labelText: 'Digite a senha novamente',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                    },
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Concordo com os ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 127, 106)),
                        ),
                        TextSpan(
                          text: "Termos & Privacidade",
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 127, 106),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _registerUser(context),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 1, 127, 106),
                ),
                child: const Text(
                  "Inscrever-se",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Já tem uma conta? ",
                    style: TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 1, 127, 106),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 1, 127, 106)),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 1, 127, 106),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 1, 127, 106),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 1, 127, 106),
            width: 1.0,
          ),
        ),
      ),
      obscureText: obscureText,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

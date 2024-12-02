import 'package:app_lembrese/models/user.dart';
import 'package:flutter/material.dart';
import 'package:app_lembrese/controller/controller_user.dart';

class ProfileScreen extends StatefulWidget {
  final String userEmail; // Recebe o email do usuário atual

  const ProfileScreen({super.key, required this.userEmail});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userController = ControllerUser();

  bool _isChangingPassword = false;
  bool _isChangingUsername = false;

  String _currentUsername = "Carregando...";
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final response = await _userController.getUserByEmail(widget.userEmail);
      if (response != null) {
        setState(() {
          _currentUsername = response['name'] ?? "Usuário";
          user = User.fromMap(response);
          _usernameController.text = _currentUsername;
        });
      } else {
        setState(() {
          _currentUsername = "Usuário não encontrado";
        });
      }
    } catch (e) {
      setState(() {
        _currentUsername = "Erro ao carregar usuário";
      });
    }
  }

  Future<void> _saveProfile() async {
    final newUsername = _usernameController.text.trim();
    final newPassword = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (_isChangingUsername && newUsername.isEmpty) {
      _showMessage("Por favor, preencha o nome de usuário.");
      return;
    }

    if (_isChangingPassword) {
      if (newPassword.isEmpty || confirmPassword.isEmpty) {
        _showMessage("Por favor, preencha os campos de senha.");
        return;
      }
      if (newPassword != confirmPassword) {
        _showMessage("As senhas não coincidem.");
        return;
      }
    }

    try {
      if (_isChangingUsername) {
        await _userController.updateUser(
          id: user?.id ?? 0,
          email: widget.userEmail,
          name: newUsername,
        );
      }
      if (_isChangingPassword) {
        await _userController.updateUser(
          id: user?.id ?? 0,
          email: widget.userEmail,
          password: newPassword,
        );
      }
      _showMessage("Perfil atualizado com sucesso!");
      Navigator.pop(context);
    } catch (e) {
      _showMessage("Erro ao salvar alterações: $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perfil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 127, 106),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Editar Perfil",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Alterar Nome de Usuário
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Alterar Nome de Usuário",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _isChangingUsername,
                    onChanged: (bool value) {
                      setState(() {
                        _isChangingUsername = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isChangingUsername)
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Novo nome de usuário",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Alterar Senha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Alterar Senha",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _isChangingPassword,
                    onChanged: (bool value) {
                      setState(() {
                        _isChangingPassword = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isChangingPassword) ...[
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Nova senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirmar nova senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // Botão Salvar Alterações
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: const Color.fromARGB(255, 1, 127, 106),
                ),
                child: const Text(
                  "Salvar Alterações",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

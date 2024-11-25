import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controladores para os campos de texto
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isChangingPassword = false; // Variável para saber se o usuário quer alterar a senha
  bool _isChangingUsername = false; // Variável para saber se o usuário quer alterar o nome de usuário

  @override
  void dispose() {
    // Limpa os controladores quando a tela for descartada
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Validação de nome de usuário (opcional)
    if (username.isEmpty && !_isChangingPassword && !_isChangingUsername) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, preencha o nome de usuário ou a senha.")),
      );
      return;
    }

    // Validação de senha apenas se o usuário quiser alterá-la
    if (_isChangingPassword) {
      if (password.isEmpty || confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Por favor, preencha os campos de nova senha.")),
        );
        return;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("As senhas não coincidem.")),
        );
        return;
      }
    }

    // Simula o salvamento
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Perfil salvo com sucesso!")),
    );

    // Após salvar, volte para a tela de configurações
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 1, 127, 106),
        iconTheme: IconThemeData(color: Colors.white), // Ícone de voltar branco
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título alterado para "Perfil" e ajustado com espaçamento
            SizedBox(height: 20), // Descer o título "Perfil"
            Align(
              alignment: Alignment.center,
              child: Text(
                "Perfil",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Opção para alterar nome de usuário
            Row(
              children: [
                Text(
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
            SizedBox(height: 10),

            // Campo para alterar o nome de usuário, aparece somente se o Switch estiver ativado
            if (_isChangingUsername) ...[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Novo nome de usuário",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Bordas arredondadas
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],

            // Opção para alterar senha
            Row(
              children: [
                Text(
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
            SizedBox(height: 10),

            // Campos para redefinir a senha, apenas se o usuário quiser
            if (_isChangingPassword) ...[
              Text(
                "Redefinir Senha",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Nova senha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Bordas arredondadas
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirmar nova senha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Bordas arredondadas
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),

            // Botão para salvar as alterações
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Color.fromARGB(255, 1, 127, 106),
              ),
              child: Text(
                "Salvar Alterações",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

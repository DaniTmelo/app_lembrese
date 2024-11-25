import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 127, 106), // Nova cor para o app bar
        title: Center(
          child: Text(
            'Sobre o App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false, // Remove o ícone de voltar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Bem-vindo ao App Lembre-se!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106), // Nova cor do título
              ),
            ),
            SizedBox(height: 10),

            // Descrição
            Text(
              'Este é um aplicativo simples para ajudar você a organizar suas tarefas diárias.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Informações adicionais
            Text(
              'Recursos principais:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106), // Nova cor dos subtítulos
              ),
            ),
            SizedBox(height: 5),
            Text(
              '- Criação e edição de tarefas\n- Definição de horários\n- Modo escuro\n- Notificações de lembretes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Versão do App
            Text(
              'Versão: 1.0.0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106), // Nova cor para a versão
              ),
            ),
            SizedBox(height: 20),

            // Informações de Contato ou Desenvolvedor
            Text(
              'Desenvolvido por: Sua Empresa',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Termos e Privacidade (se necessário)
            Text(
              'Ao usar este aplicativo, você concorda com nossos Termos de Serviço e Política de Privacidade.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Spacer(),

            // Botão para voltar
            Align(
              alignment: Alignment.bottomCenter, // Alinha o botão no centro
              child: SizedBox(
                width: double.infinity, // Define a largura do botão como 100% da tela
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Color.fromARGB(255, 1, 127, 106), // Nova cor do botão
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Volta para a tela anterior
                  },
                  child: Text(
                    "Voltar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/about',
    routes: {
      '/about': (context) => AboutScreen(),
    },
  ));
}

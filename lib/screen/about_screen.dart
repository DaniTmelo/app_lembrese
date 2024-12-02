import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 1, 127, 106), // Cor verde padronizada
        title: const Text(
          'Sobre o App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Centraliza o título
        automaticallyImplyLeading: false, // Remove o ícone de voltar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              'Bem-vindo ao App Lembre-se!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106), // Cor verde
              ),
            ),
            const SizedBox(height: 10),

            // Descrição
            const Text(
              'Este é um aplicativo simples para ajudar você a organizar suas tarefas diárias.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Informações adicionais
            const Text(
              'Recursos principais:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '- Criação e edição de tarefas\n'
              '- Definição de horários\n'
              '- Modo escuro\n'
              '- Notificações de lembretes',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Versão do App
            const Text(
              'Versão: 1.0.0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 127, 106),
              ),
            ),
            const SizedBox(height: 20),

            // Informações de Contato ou Desenvolvedor
            const Text(
              'Desenvolvido por: Wesley Bastos, José Uilliam, Italo Juliano, Heloísa Cristovão e Daniely Teixeira ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Termos e Privacidade (se necessário)
            const Text(
              'Ao usar este aplicativo, você concorda com nossos Termos de Serviço e Política de Privacidade.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const Spacer(),

            // Botão para voltar
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor:
                        const Color.fromARGB(255, 1, 127, 106), // Cor verde
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Volta para a tela anterior
                  },
                  child: const Text(
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
    debugShowCheckedModeBanner: false,
    routes: {
      '/about': (context) => const AboutScreen(),
    },
  ));
}

import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reduzindo o espaço entre as linhas do título
            SizedBox(height: 20), // Ajuste aqui para diminuir o espaço
            Text("Partiu!", style: TextStyle(fontSize: 50)), // Primeira linha
            Text("Crie sua conta", style: TextStyle(fontSize: 30)), // Segunda linha
          ],
        ),
        toolbarHeight: 120, // Ajustando a altura do AppBar
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Ajuste o espaço acima dos campos de entrada
            // Campo Nome Completo
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome Completo',
                labelStyle: TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
                prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 1, 127, 106)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color(0xFF00796B), // Define a cor da borda aqui
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está inativo
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está focado
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15), // Reduzindo o espaço entre os campos

            // Campo Endereço de Email
            TextField(
              decoration: InputDecoration(
                labelText: 'Endereço de Email',
                labelStyle: TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
                prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 1, 127, 106)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda padrão
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está inativo
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está focado
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15), // Reduzindo o espaço entre os campos

            // Campo Senha
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
                prefixIcon: Icon(Icons.lock, color:Color.fromARGB(255, 1, 127, 106)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda padrão
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está inativo
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está focado
                    width: 1.0,
                  ),
                ),
              ),
              obscureText: true, // Mantendo a propriedade para esconder o texto
            ),
            SizedBox(height: 15), // Reduzindo o espaço entre os campos

            // Campo Digite a senha novamente
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite a senha novamente',
                labelStyle: TextStyle(color: Color.fromARGB(255, 1, 127, 106)),
                prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 1, 127, 106)),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda padrão
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está inativo
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 127, 106), // Cor da borda quando o campo está focado
                    width: 1.0,
                  ),
                ),
              ),
              obscureText: true, // Mantendo a propriedade para esconder o texto
            ),
            SizedBox(height: 15), // Reduzindo o espaço entre os campos

            // Checkbox para Termos e Privacidade
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Concordo com os ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 1, 127, 106)), // Cor do texto normal
                      ),
                      TextSpan(
                        text: "Termos & Privacidade",
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 127, 106), // Cor do texto em negrito
                          fontWeight: FontWeight.bold, // Negrito
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Ajuste o espaçamento abaixo do checkbox

            // Botão Inscrever-se
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Color.fromARGB(255, 1, 127, 106),
              ),
              child: Text(
                "Inscrever-se",
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Texto "Já tem uma conta? Entrar"
            Spacer(), // Adiciona espaço entre o botão e o texto
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Já tem uma conta? ",
                    style: TextStyle(color: Color.fromARGB(255, 1, 127, 106))), // Texto normal
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, '/home'); // Altere '/home' para sua rota
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 127, 106), // Cor do texto
                      fontWeight: FontWeight.bold, // Negrito
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Espaçamento
          ],
        ),
      ),
    );
  }
}

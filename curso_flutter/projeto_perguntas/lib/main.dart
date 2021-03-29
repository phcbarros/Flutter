import 'package:flutter/material.dart';

main() => runApp(PerguntaApp());

// nó raiz da aplicação PerguntaApp
class PerguntaApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: Text('Olá Flutter!!!'),
      ),
    );
  }
}

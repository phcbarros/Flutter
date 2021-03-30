import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        { 'texto' : 'Azul', 'nota': 10 },
        { 'texto' : 'Vermelho', 'nota': 3 },
        { 'texto' : 'Verde', 'nota': 5 },
        { 'texto' : 'Preto', 'nota': 8 },
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        { 'texto' : 'Cachorro',  'nota': 8 },
        { 'texto' : 'Gato',  'nota': 10} ,
        { 'texto' : 'Boi',  'nota': 2 },
        { 'texto' : 'Peixe', 'nota': 6 },
      ]
    },
    {
      'texto': 'Qual o seu filme favorito?',
      'respostas': [
        {'texto' : 'Moana', 'nota': 10 },
        {'texto' : 'Vigadores', 'nota': 10 },
        {'texto' : 'Homem de Ferro', 'nota': 10 },
        {'texto' : 'Thor', 'nota': 10 },
        {'texto' : 'Capitão América', 'nota': 10 },
      ]
    }
  ];

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  void _responder() {
    if ( temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
              perguntas: _perguntas, 
              perguntaSelecionada: _perguntaSelecionada, 
              responder: _responder
            )
            : Resultado()
      ),
    );
  }
}

// nó raiz da aplicação PerguntaApp
class PerguntaApp extends StatefulWidget {
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}

import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': ['Azul', 'Vermelho', 'Verde', 'Preto']
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': ['Cachorro', 'Gato', 'Boi', 'Peixe']
    },
    {
      'texto': 'Qual o seu filme favorito?',
      'respostas': [
        'Moana',
        'Vigadores',
        'Homem de Ferro',
        'Thor',
        'Capitão América'
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

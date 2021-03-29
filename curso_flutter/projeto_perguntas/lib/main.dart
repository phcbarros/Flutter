import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;

  void _responder() {
    setState(() {
      _perguntaSelecionada++;
    });
    print(_perguntaSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> perguntas = [
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
        'respostas': ['Moana', 'Vigadores', 'Homem de Ferro', 'Thor']
      }
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: Column(
          children: [
            Questao(perguntas[_perguntaSelecionada]['texto']),
            Resposta(texto: 'Resposta 1', quandoSelecionado: _responder),
            Resposta(texto: 'Resposta 2', quandoSelecionado: _responder),
            Resposta(texto: 'Resposta 3', quandoSelecionado: _responder),
          ],
        ),
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

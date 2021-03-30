import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() quandoReinciarQuestionario;

  Resultado(this.pontuacao, this.quandoReinciarQuestionario);

  String get resultado {
    if (pontuacao < 8)
      return 'Parabéns!';
    else if (pontuacao < 12)
      return 'Você é bom!';
    else if (pontuacao < 16)
      return 'Impressionante!';
    else
      return 'Nível Jedi!';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            resultado,
            style: TextStyle(fontSize: 28),
          ),
        ),
        TextButton(
          onPressed: quandoReinciarQuestionario, 
          child: Text(
            'Reiniciar questionário?',
            style: TextStyle(fontSize: 18),
            )
        )
      ],
    );
  }
}

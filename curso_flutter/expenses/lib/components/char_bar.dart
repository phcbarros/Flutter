import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double value;
  //final double percentage;

  ChartBar(this.weekDay, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("R\$ ${value.toStringAsFixed(2)}"),
        Container(),
        Text(weekDay)
      ],
    );
  }
}

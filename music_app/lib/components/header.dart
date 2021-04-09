import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String label;

  Header({this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 38.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final String label;

  SubHeader({this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

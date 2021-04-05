import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool autoFocus;
  final Function(String) onSubmitted;
  final TextInputType keyboartype;

  AdaptativeTextField({
    this.controller,
    this.label,
    this.onSubmitted,
    this.autoFocus = false,
    this.keyboartype = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
      ? Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CupertinoTextField(
          controller: controller,
          onSubmitted: onSubmitted,
          placeholder: label,
          autofocus: autoFocus,
          keyboardType: keyboartype,
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12
          ),
        ),
      )
      : TextField(
          controller: controller,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            labelText: label
          ),
          autofocus: autoFocus,
          keyboardType: keyboartype,
        );
  }
}

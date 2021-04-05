import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final InputDecoration decoration;
  final bool autoFocus;
  final void Function(String) onSubmitted;
  final TextInputType keyboartype;

  AdaptativeTextField({
    this.controller,
    this.label,
    this.decoration,
    this.onSubmitted,
    this.autoFocus = false,
    this.keyboartype = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
      ? CupertinoTextField(
        controller: controller,
        onSubmitted: onSubmitted,
        //decoration: decoration,
        autofocus: autoFocus,
        keyboardType: keyboartype,
      )
      : TextField(
          controller: controller,
          onSubmitted: onSubmitted,
          decoration: decoration,
          autofocus: autoFocus,
          keyboardType: keyboartype,
        );
  }
}

import 'package:flutter/material.dart';

class FormFieldInfo {
  final String label;
  final String hint;
  final TextEditingController textController;
  bool isPassword;

  FormFieldInfo(
      {required this.label,
      required this.hint,
      this.isPassword = false,
      required this.textController});
}

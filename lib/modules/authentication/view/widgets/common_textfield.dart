import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key, required this.controller,  this.label,this.hint
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label:label==null? null: Text(label!),
        isDense: true,
        border: OutlineInputBorder(),
        hintText: hint,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      );
  }
}
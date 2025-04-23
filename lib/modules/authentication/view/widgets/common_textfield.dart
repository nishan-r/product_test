import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      required this.controller,
      this.label,
      this.hint,
      this.validator, this.obscureText, this.onSuffixIconTapped});

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Function()? onSuffixIconTapped;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        label: label == null ? null : Text(label!),
        isDense: true,
        border: OutlineInputBorder(),
        hintText: hint,
        suffixIcon: obscureText == null?null: IconButton(
          icon: obscureText! ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          onPressed: onSuffixIconTapped,
        ),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

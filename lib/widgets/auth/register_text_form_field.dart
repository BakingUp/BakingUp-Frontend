import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class RegisterTextFormField extends StatelessWidget {
  const RegisterTextFormField(
      {super.key,
      required this.validate,
      required this.hintText,
      required this.controller});
  final String? Function(String?)? validate;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkBrownColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
    );
  }
}

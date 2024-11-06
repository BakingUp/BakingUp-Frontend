import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField(
      {super.key,
      required this.passwordVisible,
      required this.controller,
      required this.validate,
      required this.hintText});
  final List<bool> passwordVisible;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final String hintText;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    passwordVisible = widget.hintText == "Password"
        ? widget.passwordVisible[0]
        : widget.passwordVisible[1];
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: darkBrownColor,
      validator: widget.validate,
      obscureText: passwordVisible,
      decoration: InputDecoration(
          errorMaxLines: 2,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: widget.hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkBrownColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: darkBeigeColor,
              ))),
    );
  }
}

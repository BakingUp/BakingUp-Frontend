import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String hintText;
  final Function error;

  const ConfirmPasswordFormField({
    super.key,
    required this.passwordController,
    required this.hintText,
    required this.confirmPasswordController,
    required this.error,
  });

  @override
  State<ConfirmPasswordFormField> createState() => _ConfirmPasswordFormFieldState();
}

class _ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  bool passwordVisible = true;
  bool hasError = false;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          isFocused = focus;
        });
      },
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.confirmPasswordController,
        builder: (context, value, child) {
          final confirmPassword = value.text;
          final password = widget.passwordController.text;

          bool passwordsMatch = confirmPassword == password && confirmPassword.isNotEmpty;

          Color borderColor;

          if (hasError) {
            borderColor = errorRedColor; 
          } else if (isFocused && passwordsMatch) {
            borderColor = greenColor; 
          } else if (isFocused && confirmPassword.isEmpty) {
            borderColor = darkBrownColor; 
          } else if (!passwordsMatch && !isFocused && confirmPassword.isNotEmpty) {
            borderColor = errorRedColor; 
          } else {
            borderColor = darkBrownColor; 
          }

          return TextFormField(
            cursorColor: darkBrownColor,
            validator: (value) {
              if (value == null || value.isEmpty) {
                widget.error();
                setState(() {
                  hasError = true;
                });
                return 'Please enter a password';
              } else if (value != password) {
                widget.error();
                setState(() {
                  hasError = true;
                });
                return "Password must be the same as above";
              } else {
                setState(() {
                  hasError = false;
                });
              }
              return null;
            },
            obscureText: passwordVisible,
            controller: widget.confirmPasswordController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: darkBeigeColor,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                hasError = value != widget.passwordController.text && value.isNotEmpty;
              });
            },
          );
        },
      ),
    );
  }
}

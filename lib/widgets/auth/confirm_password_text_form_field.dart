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
    required this.error
  });

  @override
  State<ConfirmPasswordFormField> createState() => _ConfirmPasswordFormFieldState();
}

class _ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  bool passwordVisible = true;
  ValueNotifier<bool> passwordMatchNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: passwordMatchNotifier,
      builder: (context, passwordMatch, _) {
        final borderColor = passwordMatch ? Colors.green : Colors.red;
        return Builder(
          builder: (BuildContext context) {
            return TextFormField(
              validator: (value){
                if (value == null ||
                    value.isEmpty ) {
                  widget.error();
                  return 'Please enter password';
                }else if(value != widget.passwordController.text){
                  widget.error();
                    return "Password must be same as above";
                }
                return null;
              },
              obscureText: passwordVisible,
              controller: widget.confirmPasswordController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: borderColor,
                    width: 1.5
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: darkBeigeColor,),
                ),
              ),
              onChanged: (value) {
                final password = widget.passwordController.text;
                final confirmPassword = value;
                passwordMatchNotifier.value = password == confirmPassword;
              },
            );
          },
        );
      },
    );
  }
}
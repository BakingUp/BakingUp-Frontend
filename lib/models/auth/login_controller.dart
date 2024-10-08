import 'package:flutter/material.dart';

class LoginTextEditController {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    String get email => emailController.text;
    set email(String value) => emailController.text = value;

    String get password => passwordController.text;
    set password(String value) => passwordController.text = value;

    void dispose() {
        emailController.dispose();
        passwordController.dispose();
    }
}
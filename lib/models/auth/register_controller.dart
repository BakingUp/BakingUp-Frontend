import 'package:flutter/material.dart';

class RegisterTextEditController {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();

  String get firstname => firstnameController.text;
  set firstname(String value) => firstnameController.text = value;

  String get lastname => lastnameController.text;
  set lastname(String value) => lastnameController.text = value;

  String get email => emailController.text;
  set email(String value) => emailController.text = value;

  String get password => passwordController.text;
  set password(String value) => passwordController.text = value;

  String get confirmPassword => confirmPasswordController.text;
  set confirmPassword(String value) => confirmPasswordController.text = value;

  String get phoneNumber => passwordController.text;
  set phoneNumber(String value) => passwordController.text = value;

  String get storeName => storeNameController.text;
  set storeName(String value) => storeNameController.text = value;

  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    storeNameController.dispose();
  }
}
import 'package:flutter/material.dart';

class SettingEditProfileController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();

  String get firstName => firstNameController.text;
  set firstName(String value) => firstNameController.text = value;

  String get lastName => lastNameController.text;
  set lastName(String value) => lastNameController.text = value;

  String get tel => telController.text;
  set tel(String value) => telController.text = value;

  String get email => emailController.text;
  set email(String value) => emailController.text = value;

  String get storeName => storeNameController.text;
  set storeName(String value) => storeNameController.text = value;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    telController.dispose();
    emailController.dispose();
    storeNameController.dispose();
  }
}

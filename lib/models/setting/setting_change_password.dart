import 'package:flutter/material.dart';

class SettingChangePasswordController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String get currentPassword => currentPasswordController.text;
  set currentPassword(String value) => currentPasswordController.text = value;

  String get newPassword => newPasswordController.text;
  set newPassword(String value) => newPasswordController.text = value;

  String get confirmNewPassword => confirmNewPasswordController.text;
  set confirmNewPassword(String value) =>
      confirmNewPasswordController.text = value;

  String get email => emailController.text;
  set email(String value) => emailController.text = value;
}

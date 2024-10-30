import 'package:flutter/material.dart';

class SettingExpiredColorIconController {
  final TextEditingController blackController = TextEditingController();
  final TextEditingController redController = TextEditingController();
  final TextEditingController yellowController = TextEditingController();

  String get black => blackController.text;
  set black(String value) => blackController.text = value;

  String get red => redController.text;
  set red(String value) => redController.text = value;

  String get yellow => yellowController.text;
  set yellow(String value) => yellowController.text = value;

  void dispose() {
    blackController.dispose();
    redController.dispose();
    yellowController.dispose();
  }
}

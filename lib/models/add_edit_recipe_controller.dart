import 'package:flutter/material.dart';

class AddEditRecipeController {
  final TextEditingController engNameController = TextEditingController();
  final TextEditingController thaiNameController = TextEditingController();
  final TextEditingController totalHoursController = TextEditingController();
  final TextEditingController totalMinsController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController engInstructionController = TextEditingController();
  final TextEditingController thaiInstructionController = TextEditingController();

  String get engName => engNameController.text;
  set engName(String value) => engNameController.text = value;

  String get thaiName => thaiNameController.text;
  set thaiName(String value) => thaiNameController.text = value;
  
  String get totalHours => totalHoursController.text;
  set totalHours(String value) => totalHoursController.text = value;

  String get totalMins => totalMinsController.text;
  set totalMins(String value) => totalMinsController.text = value;

  String get servings => servingsController.text;
  set servings(String value) => servingsController.text = value;

  String get engInstruction => engInstructionController.text;
  set engInstruction(String value) => engInstructionController.text = value;

  String get thaiInstruction => thaiInstructionController.text;
  set thaiInstruction(String value) => thaiInstructionController.text = value;

  void dispose() {
    engNameController.dispose();
    thaiNameController.dispose();
    totalHoursController.dispose();
    totalMinsController.dispose();
    servingsController.dispose();
    engInstructionController.dispose();
    thaiInstructionController.dispose();
  }
}

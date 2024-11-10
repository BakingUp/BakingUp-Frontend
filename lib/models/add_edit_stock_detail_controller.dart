import 'package:flutter/material.dart';

class AddEditStockDetailController {
  final TextEditingController sellByDateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String get sellByDate => sellByDateController.text;
  set sellByDate(String value) => quantityController.text = value;

  String get quantity => quantityController.text;
  set quantity(String value) => quantityController.text = value;

  String get note => noteController.text;
  set note(String value) => noteController.text = value;

  void dispose() {
    sellByDateController.dispose();
    quantityController.dispose();
    noteController.dispose();
  }
}

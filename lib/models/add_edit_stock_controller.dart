import 'package:flutter/material.dart';

class AddEditStockController {
  final TextEditingController lstController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController stockLessThanController = TextEditingController();

  String get lst => lstController.text;
  set lst(String value) => lstController.text = value;

  String get sellingPrice => sellingPriceController.text;
  set sellingPrice(String value) => sellingPriceController.text = value;

  String get expirationDate => expirationDateController.text;
  set expirationDate(String value) => expirationDateController.text = value;

  String get stockLessThan => stockLessThanController.text;
  set stockLessThan(String value) => stockLessThanController.text = value;

  void dispose() {
    lstController.dispose();
    sellingPriceController.dispose();
    expirationDateController.dispose();
    stockLessThanController.dispose();
  }
}

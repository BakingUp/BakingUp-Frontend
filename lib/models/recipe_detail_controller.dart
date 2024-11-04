import 'package:flutter/material.dart';

class RecipeDetailController {
  final TextEditingController hiddenCostController = TextEditingController();
  final TextEditingController laborCostController = TextEditingController();
  final TextEditingController profitMarginController = TextEditingController();

  String get hiddenCost => hiddenCostController.text;
  set hiddenCost(String value) => hiddenCostController.text = value;

  String get laborCost => laborCostController.text;
  set laborCost(String value) => laborCostController.text = value;

  String get profitMargin => profitMarginController.text;
  set profitMargin(String value) => profitMarginController.text = value;

  void dispose() {
    hiddenCostController.dispose();
    laborCostController.dispose();
    profitMarginController.dispose();
  }
}

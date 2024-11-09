import 'package:flutter/material.dart';

class AddEditOrderController {
  final TextEditingController orderTakenByController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController orderDateController = TextEditingController();

  String get orderTakenBy => orderTakenByController.text;
  set orderTakenBy(String value) => orderTakenByController.text = value;

  String get note => noteController.text;
  set note(String value) => noteController.text = value;

  String get date => orderDateController.text;
  set date(String value) => orderDateController.text = value;

  void dispose() {
    orderTakenByController.dispose();
    noteController.dispose();
    orderDateController.dispose();
  }
}

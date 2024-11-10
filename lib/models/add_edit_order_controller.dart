import 'package:flutter/material.dart';

class AddEditOrderController {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneNumberController = TextEditingController();
  final TextEditingController orderTakenByController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController orderDateController = TextEditingController();
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController pickUpTimeController = TextEditingController();


 String get customerPhoneNumberValue => customerPhoneNumberController.text;
  set customerPhoneNumberValue(String value) => customerPhoneNumberController.text = value;

  String get customerNameValue => customerNameController.text;
  set customerNameValue(String value) => customerNameController.text = value;

  String get orderTakenBy => orderTakenByController.text;
  set orderTakenBy(String value) => orderTakenByController.text = value;

  String get note => noteController.text;
  set note(String value) => noteController.text = value;

  String get date => orderDateController.text;
  set date(String value) => orderDateController.text = value;

  String get pickUpDate => pickUpDateController.text;
  set pickUpDate(String value) => pickUpDateController.text = value;

  String get pickUpTime => pickUpTimeController.text;
  set pickUpTime(String value) => pickUpTimeController.text = value;


  void dispose() {
    orderTakenByController.dispose();
    noteController.dispose();
    orderDateController.dispose();
    pickUpDateController.dispose();
    pickUpTimeController.dispose();
    customerNameController.dispose();
    customerPhoneNumberController.dispose();
  }
}

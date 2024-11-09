import 'package:flutter/material.dart';

class SettingFixCostController {
  final TextEditingController rentController = TextEditingController();
  final TextEditingController salariesController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController subscriptionsController = TextEditingController();
  final TextEditingController advertisingController = TextEditingController();
  final TextEditingController electricityController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  final TextEditingController gasController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String get rent => rentController.text;
  set rent(String value) => rentController.text = value;

  String get salaries => salariesController.text;
  set salaries(String value) => salariesController.text = value;

  String get insurance => insuranceController.text;
  set insurance(String value) => insuranceController.text = value;

  String get subscription => subscriptionsController.text;
  set subscription(String value) => subscriptionsController.text = value;

  String get advertising => advertisingController.text;
  set advertising(String value) => advertisingController.text = value;

  String get electricity => electricityController.text;
  set electricity(String value) => electricityController.text = value;

  String get water => waterController.text;
  set water(String value) => waterController.text = value;

  String get gas => gasController.text;
  set gas(String value) => gasController.text = value;

  String get other => otherController.text;
  set other(String value) => otherController.text = value;

  String get note => noteController.text;
  set note(String value) => noteController.text = value;
}

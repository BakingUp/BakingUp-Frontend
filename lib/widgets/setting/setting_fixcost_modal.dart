import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/setting.dart';
import 'package:bakingup_frontend/models/setting/setting_fixcost_controller.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/setting/setting_fixcost_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingFixCostModal extends StatefulWidget {
  const SettingFixCostModal({super.key});

  @override
  State<SettingFixCostModal> createState() => _SettingFixCostModalState();
}

class _SettingFixCostModalState extends State<SettingFixCostModal> {
  SettingFixCostController fixcostController = SettingFixCostController();
  String id = "";
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();
  bool errorMessage = false;
  Future<void> _getFixCost() async {
    try {
      final response = await NetworkService.instance.get(
          '/api/settings/getFixCost?user_id=$userId&created_at=2024-10-01T00:00:00Z');
      final fixcostResponse = UserFixCostResponse.fromJson(response);
      final data = fixcostResponse.data;

      setState(() {
        id = data.id;
        fixcostController.rent = data.rent.toString();
        fixcostController.salaries = data.salaries.toString();
        fixcostController.insurance = data.insurance.toString();
        fixcostController.subscription = data.subscriptions.toString();
        fixcostController.advertising = data.advertising.toString();
        fixcostController.electricity = data.electricity.toString();
        fixcostController.water = data.water.toString();
        fixcostController.gas = data.gas.toString();
        fixcostController.other = data.other.toString();
        fixcostController.note = data.note.toString();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _changeFixCost() async {
    try {
      final data = {
        "fix_cost_id": id,
        "rent": double.parse(fixcostController.rent),
        "salaries": double.parse(fixcostController.salaries),
        "insurance": double.parse(fixcostController.insurance),
        "subscriptions": double.parse(fixcostController.subscription),
        "advertising": double.parse(fixcostController.advertising),
        "electricity": double.parse(fixcostController.electricity),
        "water": double.parse(fixcostController.water),
        "gas": double.parse(fixcostController.gas),
        "other": double.parse(fixcostController.other),
        "note": fixcostController.note,
      };

      await NetworkService.instance
          .put('/api/settings/changeFixCost', data: data);
//ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleNoErrorMessage() {
    setState(() {
      errorMessage = false;
    });
  }

  void handleErrorMessage() {
    setState(() {
      errorMessage = true;
    });
  }

  @override
  void initState() {
    _getFixCost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Fix-Cost",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Average fixed cost per month for your bakery shop",
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 25,
              ),
              SettingFixCostItem(
                title: "Rent",
                controller: fixcostController.rentController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Salaries",
                controller: fixcostController.salariesController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Insurance",
                controller: fixcostController.insuranceController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Subscriptions",
                controller: fixcostController.subscriptionsController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Advertising",
                controller: fixcostController.advertisingController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Electricity",
                controller: fixcostController.electricityController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Water",
                controller: fixcostController.waterController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Gas",
                controller: fixcostController.gasController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingFixCostItem(
                title: "Other",
                controller: fixcostController.otherController,
                errorFunction: handleErrorMessage,
                errorNoFunction: handleNoErrorMessage,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Note",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400),
              ),
              TextFormField(
                  controller: fixcostController.noteController,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkGreyColor, width: 0.5)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkGreyColor, width: 0.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: blackColor),
                  )),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BakingUpLongActionButton(
                    title: 'Cancel',
                    color: greyColor,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    isDisabled: false,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  BakingUpLongActionButton(
                    title: 'Save',
                    color: lightGreenColor,
                    onClick: () {
                      if (_formKey.currentState!.validate() &&
                          errorMessage == false) {
                        _changeFixCost();
                      }
                    },
                    isDisabled: false,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/setting.dart';
import 'package:bakingup_frontend/models/setting/setting_expired_color_icon._controller.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/setting/setting_expired_color_icon_item.dart';
import 'package:flutter/material.dart';

class SettingExpiredColorIconModal extends StatefulWidget {
  const SettingExpiredColorIconModal({super.key});

  @override
  State<SettingExpiredColorIconModal> createState() =>
      _SettingExpiredColorIconModalState();
}

class _SettingExpiredColorIconModalState
    extends State<SettingExpiredColorIconModal> {
  final SettingExpiredColorIconController _expiredColorIconController =
      SettingExpiredColorIconController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _getExpirationDateColors() async {
    try {
      final response = await NetworkService.instance
          .get('/api/settings/getColorExpired?user_id=1');
      final expirationColorsResponse =
          UserExpiredColorResponse.fromJson(response);
      final data = expirationColorsResponse.data;

      setState(() {
        _expiredColorIconController.black = data.blackExpirationDate.toString();
        _expiredColorIconController.red = data.redExpirationDate.toString();
        _expiredColorIconController.yellow =
            data.yellowExpirationDate.toString();
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _changeExpiredColorIcon() async {
    try {
      final data = {
        "user_id": "1",
        "black_expiration_date": int.parse(_expiredColorIconController.black),
        "red_expiration_date": int.parse(_expiredColorIconController.red),
        "yellow_expiration_date": int.parse(_expiredColorIconController.yellow)
      };
      await NetworkService.instance
          .put('/api/settings/changeColorExpired', data: data);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    _getExpirationDateColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Color icons',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Set your expiring Threshold (Days)',
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              SettingExpiredColorIconItem(
                color: blackColor,
                days: _expiredColorIconController.blackController,
              ),
              const SizedBox(
                height: 15,
              ),
              SettingExpiredColorIconItem(
                color: redColor,
                days: _expiredColorIconController.redController,
              ),
              const SizedBox(
                height: 15,
              ),
              SettingExpiredColorIconItem(
                color: yellowColor,
                days: _expiredColorIconController.yellowController,
              ),
              const SizedBox(
                height: 15,
              ),
              SettingExpiredColorIconItem(
                color: greenColor,
                days: _expiredColorIconController.yellowController,
                isGreen: true,
              ),
              const SizedBox(
                height: 40,
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
                      if (_formKey.currentState!.validate()) {
                        _changeExpiredColorIcon();
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

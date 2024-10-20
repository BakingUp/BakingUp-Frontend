import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/models/setting.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown_bottom_sheet.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final int _currentDrawerIndex = 5;
  User? user = FirebaseAuth.instance.currentUser;
  final user_id = "1";
  final List<String> languageOption = ["English", "Thai"];
  String selectedLanguage = "";

  Future<void> _deleteAccount() async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    try {
      if (user != null) {
        await user?.delete();
      }

      await NetworkService.instance
          .delete('/api/settings/deleteAccount?user_id=${user?.uid}');

      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil(
          loginRoute,
          (route) => false,
        );
      }
    } catch (error) {
      if (mounted) {
        Navigator.of(context).pop();

        Navigator.of(context).overlay!.insert(
          OverlayEntry(
            builder: (BuildContext context) {
              return const BakingUpErrorTopNotification(
                message:
                    "Sorry, we couldn’t delete the user account due to a system error. Please try again later.",
              );
            },
          ),
        );
      }
    }
  }

  Future<void> _getUserLanguage() async {
    final response = await NetworkService.instance
        .get('/api/settings/getLanguage?user_id=$user_id');

    final userLanguageResponse = UserLanguageResponse.fromJson(response);
    final data = userLanguageResponse.data;
    setState(() {
      selectedLanguage = data.language;
    });
  }

  Future<void> _changeUserLanguage() async {
    final data = {"user_id": user_id, "language": selectedLanguage};
    try {
      await NetworkService.instance
          .put('/api/settings/changeLanguage', data: data);
    } catch (e) {
      if (mounted) {
        Navigator.of(context).overlay!.insert(
          OverlayEntry(
            builder: (BuildContext context) {
              return const BakingUpErrorTopNotification(
                message:
                    "Sorry, we couldn’t update the user language due to a system error. Please try again later.",
              );
            },
          ),
        );
      }
    }
  }

  @override
  void initState() {
    _getUserLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            "Setting",
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: backgroundColor,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: BakingUpDrawer(
          currentDrawerIndex: _currentDrawerIndex,
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.07,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Accounts",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/user_setting_icon.png',
                        scale: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/password_setting_icon.png',
                        scale: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Change Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Text(
                "Setting",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/language_setting_icon.png',
                        scale: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Language",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  if (selectedLanguage != "") {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: backgroundColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return BakingUpDropdownBottomSheet(
                          options: languageOption,
                          topic: 'Language',
                          selectedOption: selectedLanguage,
                          onApply: (String value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                            _changeUserLanguage();
                          },
                        );
                      },
                    );
                  } else {
                    Navigator.of(context).overlay!.insert(
                      OverlayEntry(
                        builder: (BuildContext context) {
                          return const BakingUpErrorTopNotification(
                            message:
                                "Sorry, we couldn’t get the user language due to a system error. Please try again later.",
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/fixcost_setting_icon.png',
                        scale: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Fix-Cost",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Ingredient icons",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/color_setting_icon.png',
                        scale: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Color icons",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.07,
                    top: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 1,
                        color: blackColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Delete Account",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "All data associated with your account will be deleted.",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BakingUpDialog(
                                      title: "Confirm Delete?",
                                      imgUrl: "assets/icons/delete_warning.png",
                                      content:
                                          "This will permanently delete this account. Are you sure you want to proceed?",
                                      grayButtonTitle: "Cancel",
                                      secondButtonTitle: "Delete",
                                      secondButtonColor: lightRedColor,
                                      grayButtonOnClick: () {
                                        Navigator.pop(context);
                                      },
                                      secondButtonOnClick: () {
                                        Navigator.of(context).pop();
                                        _deleteAccount();
                                      },
                                    );
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  side: BorderSide(color: redColor)),
                            ),
                            child: Text(
                              "Delete account",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: redColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}

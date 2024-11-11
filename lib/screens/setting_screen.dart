import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/models/setting.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown_bottom_sheet.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/setting/setting_change_password_dialog.dart';
import 'package:bakingup_frontend/widgets/setting/setting_change_password_email_dialog.dart';
import 'package:bakingup_frontend/widgets/setting/setting_edit_profile.dart';
import 'package:bakingup_frontend/widgets/setting/setting_expired_color_icon_modal.dart';
import 'package:bakingup_frontend/widgets/setting/setting_fixcost_modal.dart';
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
  final List<String> languageOption = ["English", "Thai"];
  String selectedLanguage = "";
  final userId = FirebaseAuth.instance.currentUser!.uid;
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
        .get('/api/settings/getLanguage?user_id=$userId');

    final userLanguageResponse = UserLanguageResponse.fromJson(response);
    final data = userLanguageResponse.data;
    setState(() {
      selectedLanguage = data.language;
    });
  }

  Future<void> _changeUserLanguage() async {
    final data = {"user_id": userId, "language": selectedLanguage};
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

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingChangePasswordDialog(
          title: "Change Password",
          content: "Enter your old password to create a new password",
          redButtonFunction: () {
            Navigator.of(context).pop();

            _showForgotPasswordDialog();
          },
          grayButtonOnClick: () {
            Navigator.of(context).pop();
          },
          secondButtonTitle: "Confirm",
          secondButtonOnClick: () {
            Navigator.of(context).pop();

            _showSetNewPasswordDialog();
          },
        );
      },
    );
  }

  void _showSetNewPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingChangePasswordDialog(
          title: "Password reset",
          content: "Set a new password",
          resetPasswordMode: true,
          grayButtonOnClick: () {
            Navigator.of(context).pop();
          },
          secondButtonTitle: "Set password",
          secondButtonOnClick: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BakingUpDialog(
                    title: 'Password Changed Successfully',
                    imgUrl: 'assets/icons/success.png',
                    content:
                        'For security purposes, you will need to log in again with your new password on other devices.',
                    grayButtonTitle: 'OK',
                    grayButtonOnClick: () {
                      Navigator.of(context).pop();
                    },
                  );
                });
          },
        );
      },
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingChangePasswordDialog(
          title: "Change Password",
          content: "Enter your email to create new password",
          backButton: true,
          backButtonFunction: () {
            Navigator.of(context).pop();

            _showPasswordDialog();
          },
          grayButtonOnClick: () {
            Navigator.of(context).pop();
          },
          secondButtonTitle: "Confirm",
          secondButtonOnClick: () {
            Navigator.of(context).pop();
            _showVerifyEmailDialog();
          },
        );
      },
    );
  }

  void _showVerifyEmailDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SettingChangePasswordEmailDialog();
        });
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
            "Settings",
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
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
        bottomNavigationBar: const BottomNavbar(),
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingEditProfile()));
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
                onTap: () async {
                  _showPasswordDialog();
                },
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
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: backgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.90,
                          child: DraggableScrollableSheet(
                            initialChildSize: 1,
                            minChildSize: 1,
                            maxChildSize: 1,
                            builder: (context, scrollController) {
                              return const SettingFixCostModal();
                            },
                          ));
                    },
                  );
                },
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
                onTap: () {
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
                        return const SettingExpiredColorIconModal();
                      });
                },
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

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final int _currentDrawerIndex = 10;
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
                            onPressed: () {},
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

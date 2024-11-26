import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/setting/setting_edit_profile_controller.dart';
import 'package:bakingup_frontend/models/user_info.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/profile/profile_title.dart';
import 'package:bakingup_frontend/widgets/setting/setting_edit_profile_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingEditProfile extends StatefulWidget {
  const SettingEditProfile({super.key});

  @override
  State<SettingEditProfile> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<SettingEditProfile> {
  bool isLoading = true;
  bool isError = false;
  String userID = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  final SettingEditProfileController _editProfileControllers =
      SettingEditProfileController();
  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
    _fetchUserInfo();
  }

  void getUserInfo() {
    setState(() {
      userID = auth.currentUser!.uid;
      _editProfileControllers.email = auth.currentUser!.email!;
    });
  }

  Future<void> _fetchUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/user/getUserInfo/?user_id=$userID');
      final userInfoResponse = UserInfoResponse.fromJson(response);
      final data = userInfoResponse.data;

      if (response == null) {
        throw Exception("Response is null");
      }
      setState(() {
        firstName = data.firstName;
        lastName = data.lastName;
        _editProfileControllers.firstName = data.firstName;
        _editProfileControllers.lastName = data.lastName;
        _editProfileControllers.tel = data.tel;
        _editProfileControllers.storeName = data.storeName;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _editUserProfile() async {
    try {
      var data = {
        "user_id": userID,
        "first_name": _editProfileControllers.firstName,
        "last_name": _editProfileControllers.lastName,
        "tel": _editProfileControllers.tel,
        "store_name": _editProfileControllers.storeName,
      };

      await NetworkService.instance.put("/api/user/editUserInfo", data: data);
    } catch (e) {
      //ignore: use_build_context_synchronously
      Navigator.of(context).overlay!.insert(
        OverlayEntry(
          builder: (BuildContext context) {
            return const BakingUpErrorTopNotification(
              message:
                  "Sorry, we couldn’t update your user information due to a system error. Please try again later.",
            );
          },
        ),
      );
    }

    _fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: lightYellowColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: lightYellowColor,
                  height: 70,
                  width: double.infinity,
                ),
                Positioned(
                  top: 10,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: darkBrownColor,
                        child: Text(
                          !isLoading &&
                                  firstName.isNotEmpty &&
                                  lastName.isNotEmpty
                              ? "${firstName[0]}${lastName[0]}"
                              : "",
                          style: TextStyle(
                            fontSize: 32,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ProfileTitle(
                          isLoading: isLoading,
                          firstName: firstName,
                          lastName: lastName)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingEditProfileItem(
                    isLoading: isLoading,
                    label: "Firstname",
                    text: _editProfileControllers.firstNameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SettingEditProfileItem(
                    isLoading: isLoading,
                    label: "Lastname",
                    text: _editProfileControllers.lastNameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SettingEditProfileItem(
                    isLoading: isLoading,
                    label: "Tel",
                    text: _editProfileControllers.telController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SettingEditProfileItem(
                    isLoading: isLoading,
                    label: "Email",
                    text: _editProfileControllers.emailController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SettingEditProfileItem(
                    isLoading: isLoading,
                    label: "Store Name",
                    text: _editProfileControllers.storeNameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BakingUpLongActionButton(
                  title: "Cancel",
                  color: greyColor,
                  isDisabled: false,
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                BakingUpLongActionButton(
                  title: "Save",
                  color: lightGreenColor,
                  isDisabled: false,
                  onClick: () {
                    _editUserProfile();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BakingUpDialog(
                            title: 'Update user info Successfully',
                            imgUrl: 'assets/icons/success.png',
                            content:
                                'Your user information have been updated successfully',
                            grayButtonTitle: 'OK',
                            grayButtonOnClick: () {
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}

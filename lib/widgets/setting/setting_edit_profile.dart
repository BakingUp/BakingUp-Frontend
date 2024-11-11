import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/user_info.dart';
import 'package:bakingup_frontend/screens/setting_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_text.dart';
import 'package:bakingup_frontend/widgets/profile/profile_title.dart';
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

  // final int _currentDrawerIndex = 1;
  String firstName = '';
  String lastName = '';
  String tel = '';
  String email = '';
  String storeName = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
    _fetchUserInfo();
  }

  void getUserInfo() {
    setState(() {
      userID = auth.currentUser!.uid;
      email = auth.currentUser!.email!;
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
        tel = data.tel;
        storeName = data.storeName;
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

  // Future<void> _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
            );
          },
        ),
      ),
      body: Column(
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
                OrderDetailText(
                    isLoading: isLoading, text: firstName, label: 'Firstname'),
                const SizedBox(
                  height: 5,
                ),
                OrderDetailText(
                    isLoading: isLoading, text: lastName, label: 'Lastname'),
                const SizedBox(
                  height: 5,
                ),
                OrderDetailText(isLoading: isLoading, text: tel, label: 'Tel'),
                const SizedBox(
                  height: 5,
                ),
                OrderDetailText(
                    isLoading: isLoading, text: email, label: 'Email'),
                const SizedBox(
                  height: 5,
                ),
                OrderDetailText(
                    isLoading: isLoading, text: storeName, label: 'Store Name'),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BakingUpLongActionButton(
                title: "Cancel",
                color: greyColor,
                isDisabled: false,
              ),
              BakingUpLongActionButton(
                title: "Confirm",
                color: lightGreenColor,
                isDisabled: false,
              )
            ],
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/models/user_info.dart';
import 'package:bakingup_frontend/screens/setting_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_text.dart';
import 'package:bakingup_frontend/widgets/profile/profile_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  bool isError = false;
  String userID = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  final int _currentDrawerIndex = 1;
  String firstName = '';
  String lastName = '';
  String tel = '';
  String email = '';
  String storeName = '';
  List<ProductionQueue> productionQueue = [];

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
        productionQueue = data.productionQueue!;
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: lightYellowColor,
        scrolledUnderElevation: 0,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen()));
            },
          ),
        ],
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      bottomNavigationBar: const BottomNavbar(),
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
                // Text(
                //   productionQueue.isEmpty ? '' : 'Production Queue',
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontFamily: 'Inter',
                //     fontStyle: FontStyle.normal,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // ProductionQueueList(
                //     productionQueue: productionQueue, isLoading: isLoading)
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierColor: const Color(0xC7D9D9D9),
                  builder: (BuildContext context) {
                    return BakingUpDialog(
                      title: 'Confirm Logout?',
                      imgUrl: 'assets/icons/warning.png',
                      content: 'Are you sure to logout from this account?',
                      grayButtonTitle: 'Cancel',
                      secondButtonTitle: 'Confirm',
                      grayButtonOnClick: () {
                        Navigator.pop(context);
                      },
                      secondButtonOnClick: () {
                        _signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      },
                    );
                  });
            },
            child: Text(
              "Log out",
              style: TextStyle(
                color: redColor,
                fontFamily: 'Poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 0.5,
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}

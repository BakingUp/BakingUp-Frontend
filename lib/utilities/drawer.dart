import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/models/user_info.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BakingUpDrawer extends StatefulWidget {
  final int currentDrawerIndex;
  const BakingUpDrawer({super.key, required this.currentDrawerIndex});

  @override
  State<BakingUpDrawer> createState() => _BakingUpDrawerState();
}

class _BakingUpDrawerState extends State<BakingUpDrawer> {
  User? user;
  UserInfoData userInfo =
      UserInfoData(firstName: "", lastName: "", tel: "", storeName: "");
  bool isLoading = true;
  bool isError = false;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _getUserInfo() async {
    setState(() {
      isLoading = true;
      user = FirebaseAuth.instance.currentUser;
    });

    try {
      final userID = user!.uid;

      final response = await NetworkService.instance
          .get('/api/user/getUserInfo?user_id=$userID');

      final userResponse = UserInfoResponse.fromJson(response);
      final data = userResponse.data;

      setState(() {
        userInfo = data;
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

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: 120,
                color: beigeColor,
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        if (isLoading)
                          Shimmer.fromColors(
                            baseColor: greyColor,
                            highlightColor: whiteColor,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: brownColor, shape: BoxShape.circle),
                            child: Text(
                              '${userInfo.firstName.isNotEmpty ? userInfo.firstName[0] : ''}'
                              '${userInfo.lastName.isNotEmpty ? userInfo.lastName[0] : ''}',
                              style: TextStyle(
                                color: beigeColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isLoading)
                            Shimmer.fromColors(
                              baseColor: greyColor,
                              highlightColor: whiteColor,
                              child: Container(
                                width: 100,
                                height: 20,
                                color: Colors.white,
                              ),
                            )
                          else
                            Text(
                              '${userInfo.firstName} ${userInfo.lastName}',
                              style: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          if (isLoading)
                            Shimmer.fromColors(
                              baseColor: greyColor,
                              highlightColor: whiteColor,
                              child: Container(
                                width: 80,
                                height: 15,
                                color: Colors.white,
                              ),
                            )
                          else
                            Text(
                              user?.email ?? '',
                              style: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              MenuItem(
                  index: 0,
                  currentDrawerIndex: widget.currentDrawerIndex,
                  url: "assets/icons/home_icon.png",
                  title: "Home",
                  routeName: homeRoute),
              MenuItem(
                  index: 1,
                  currentDrawerIndex: widget.currentDrawerIndex,
                  url: "assets/icons/profile_icon.png",
                  title: "Profile",
                  routeName: profileRoute),
              MenuItem(
                  index: 2,
                  currentDrawerIndex: widget.currentDrawerIndex,
                  url: "assets/icons/warehouse_icon.png",
                  title: "Warehouse",
                  routeName: warehouseRoute),
              MenuItem(
                  index: 3,
                  currentDrawerIndex: widget.currentDrawerIndex,
                  url: "assets/icons/order_icon.png",
                  title: "Order",
                  routeName: orderRoute),
              MenuItem(
                  index: 4,
                  currentDrawerIndex: widget.currentDrawerIndex,
                  url: "assets/icons/bakery_icon.png",
                  title: "Bakery Stock",
                  routeName: stockRoute),
              MenuItem(
                  index: 5,
                  currentDrawerIndex: widget.currentDrawerIndex,
                  url: "assets/icons/setting_icon.png",
                  title: "Setting",
                  routeName: settingsRoute),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
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

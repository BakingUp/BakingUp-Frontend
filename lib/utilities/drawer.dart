import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/utilities/menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BakingUpDrawer extends StatelessWidget {
  const BakingUpDrawer({super.key, required this.currentDrawerIndex});
  final int currentDrawerIndex;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/4a30/7ce0/21b6607d5de531d52805588265ca8b8c?Expires=1729468800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DqHblQJTVuknYWdZNhk981CJgPQlvVgVVFwDDrq~uwTxKT0UCenjIoeYTcoG8Y~fdK15PSpNJqGg2U82aATQFNOyBjTr4J5iArqnKPWV1lUs2f9BVIt1WlvbCJ5AnUV273QDJTkxnHldua02Rfs9gzIhpTMvK2XCwgEOtJvUA51x8RfHUY8dqVu~sEqkC671N6DpyHLA9Tps89UjEjHHVfwWSXCkLD5-d8TFIjquLaJONAVeCoyopt01wGzNBDXhYxJi3E-39fGRcA3pyXHxQhV-zJIeAY0uyZc29oM3hCHxGTzMqr3n7KKeKWVGFMZDG9Z~N8SjzUXSHTP5~omIlg__',
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orathai J.",
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "orathai.jam@gmail.com",
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const MenuItem(
                  currentDrawerIndex: 0,
                  url: "assets/icons/home_icon.png",
                  title: "Home",
                  routeName: homeRoute),
              const MenuItem(
                  currentDrawerIndex: 1,
                  url: "assets/icons/profile_icon.png",
                  title: "Profile",
                  routeName: profileRoute),
              const MenuItem(
                  currentDrawerIndex: 2,
                  url: "assets/icons/warehouse_icon.png",
                  title: "Warehouse",
                  routeName: warehouseRoute),
              const MenuItem(
                  currentDrawerIndex: 3,
                  url: "assets/icons/order_icon.png",
                  title: "Order",
                  routeName: orderRoute),
              const MenuItem(
                  currentDrawerIndex: 4,
                  url: "assets/icons/bakery_icon.png",
                  title: "Bakery Stock",
                  routeName: stockRoute),
              const MenuItem(
                  currentDrawerIndex: 5,
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
              "Logout",
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

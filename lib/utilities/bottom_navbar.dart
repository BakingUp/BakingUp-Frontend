import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:bakingup_frontend/screens/order_screen.dart';
import 'package:bakingup_frontend/screens/profile_screen.dart';
import 'package:bakingup_frontend/screens/warehouse_screen.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: backgroundColor,
      height: 50,
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            },
            child: Image.asset(
              "assets/icons/home_icon.png",
              width: 20,
              height: 20,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const WarehouseScreen()),
                (route) => false,
              );
            },
            child: Image.asset(
              "assets/icons/warehouse_icon.png",
              width: 27,
              height: 27,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OrderScreen()),
                (route) => false,
              );
            },
            child: Image.asset(
              "assets/icons/order_icon.png",
              width: 24,
              height: 24,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
                (route) => false,
              );
            },
            child: Image.asset(
              "assets/icons/profile_icon.png",
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
    );
  }
}

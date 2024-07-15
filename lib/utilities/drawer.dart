import 'package:bakingup_frontend/constants/routes.dart';
import 'package:flutter/material.dart';

class BakingUpDrawer extends StatelessWidget {
  const BakingUpDrawer({super.key, required this.currentDrawerIndex});
  final int currentDrawerIndex;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            tileColor: currentDrawerIndex == 0
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 1
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 2
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(homeRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 3
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Warehouse',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(warehouseRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 4
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Ingredient',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  addEditIngredientRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 5
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Recipe',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(recipeDetailRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 6
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Order',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(orderRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 7
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(notificationRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 8
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(profileRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 9
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Stock',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(stockRoute, (route) => false);
            },
          ),
          ListTile(
            tileColor: currentDrawerIndex == 10
                ? const Color.fromRGBO(217, 217, 217, 0.5)
                : Colors.white,
            title: const Row(
              children: [
                Text(
                  'Setting',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    height: 0.5,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(settingsRoute, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

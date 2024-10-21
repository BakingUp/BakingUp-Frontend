import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final int index;
  final int currentDrawerIndex;
  final String url;
  final String title;
  final String routeName;
  const MenuItem(
      {super.key,
      required this.index,
      required this.currentDrawerIndex,
      required this.url,
      required this.title,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: index == currentDrawerIndex ? greyColor : whiteColor,
      title: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          ClipRRect(
            child: Image.asset(
              url,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: blackColor,
              fontFamily: 'Poppins',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 0.5,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(routeName, (route) => false);
      },
    );
  }
}

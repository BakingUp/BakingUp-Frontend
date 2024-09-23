import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpCircularBackButton extends StatelessWidget {
  const BakingUpCircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'back',
      backgroundColor: beigeColor.withOpacity(0.76),
      onPressed: () {},
      elevation: 5,
      shape: const CircleBorder(),
      mini: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: blackColor,
        ),
      ),
    );
  }
}

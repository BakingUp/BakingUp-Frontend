import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpCircularAddButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const BakingUpCircularAddButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add',
      backgroundColor: beigeColor,
      onPressed: () {
        onPressed!();
      },
      elevation: 5,
      shape: const CircleBorder(),
      mini: true,
      child: Icon(
        Icons.add,
        size: 25,
        color: blackColor,
      ),
    );
  }
}

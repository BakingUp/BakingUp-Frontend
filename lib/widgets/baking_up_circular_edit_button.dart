import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpCircularEditButton extends StatelessWidget {
  const BakingUpCircularEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'edit',
      backgroundColor: beigeColor.withOpacity(0.76),
      onPressed: () {},
      elevation: 5,
      shape: const CircleBorder(),
      mini: true,
      child: Image.asset(
        'assets/icons/edit.png',
        fit: BoxFit.contain,
        height: 20,
      ),
    );
  }
}

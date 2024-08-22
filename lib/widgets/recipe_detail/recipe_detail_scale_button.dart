import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class RecipeDetailScaleButton extends StatelessWidget {
  const RecipeDetailScaleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        heroTag: 'add',
        backgroundColor: lightYellowColor,
        onPressed: () {},
        elevation: 5,
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/icons/scale.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}

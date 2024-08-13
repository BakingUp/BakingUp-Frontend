import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditAddRecipeIngredientButton extends StatelessWidget {
  const AddEditAddRecipeIngredientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
        height: 90,
        decoration: BoxDecoration(
          color: greyColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Image.asset('assets/icons/add.png', scale: 0.5),
        ));
  }
}

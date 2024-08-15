import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditRecipeImageUploader extends StatelessWidget {
  const AddEditRecipeImageUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor,
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize
                .min, // This makes the Row only take as much space as needed
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add image",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset('assets/icons/add.png'),
            ],
          ),
        ),
      ),
    );
  }
}

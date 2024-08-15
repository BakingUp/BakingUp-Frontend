import 'package:flutter/material.dart';

class AddEditRecipeTitle extends StatelessWidget {
  final String title;
  final MainAxisAlignment? mainAxisAlignment;
  const AddEditRecipeTitle(
      {super.key, required this.title, this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

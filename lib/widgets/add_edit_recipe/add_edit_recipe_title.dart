import 'package:flutter/material.dart';

class AddEditRecipeTitle extends StatelessWidget {
  final String title;
  final MainAxisAlignment? mainAxisAlignment;
  final double? fontSize;
  final FontWeight? fontWeight;
  const AddEditRecipeTitle({
    super.key,
    required this.title,
    this.mainAxisAlignment,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 20,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

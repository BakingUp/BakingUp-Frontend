import 'package:flutter/material.dart';

class AddIngredientReceiptEditButton extends StatelessWidget {
  const AddIngredientReceiptEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25, // Set the desired width
      child: Image.asset(
        'assets/icons/edit.png',
        fit: BoxFit.contain, // Ensure the image fits within the container
      ),
    );
  }
}

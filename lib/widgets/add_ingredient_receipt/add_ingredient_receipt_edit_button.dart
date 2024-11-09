import 'package:bakingup_frontend/screens/add_ingredient_receipt_detail_screen.dart';
import 'package:flutter/material.dart';

class AddIngredientReceiptEditButton extends StatelessWidget {
  final String? ingredientName;
  final String? ingredientQuantity;
  final String? ingredientPrice;
  const AddIngredientReceiptEditButton({
    super.key,
    this.ingredientName,
    this.ingredientQuantity,
    this.ingredientPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => AddIngredientReceiptDetailScreen(
              ingredientName: ingredientName ?? '',
              ingredientQuantity: ingredientQuantity ?? '',
              ingredientPrice: ingredientPrice ?? '',
            ),
          ),
        );
      },
      child: SizedBox(
        width: 25, // Set the desired width
        child: Image.asset(
          'assets/icons/edit.png',
          fit: BoxFit.contain, // Ensure the image fits within the container
        ),
      ),
    );
  }
}

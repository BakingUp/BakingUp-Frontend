import 'package:bakingup_frontend/models/get_all_ingredient_ids_and_names.dart';
import 'package:bakingup_frontend/screens/add_ingredient_receipt_detail_screen.dart';
import 'package:flutter/material.dart';

class AddIngredientReceiptEditButton extends StatelessWidget {
  final String? ingredientName;
  final String? ingredientQuantity;
  final String? ingredientPrice;
  final List<Ingredient>? ingredientIdsAndNames;
  final int? index;
  final Function(
    dynamic,
    dynamic,
    dynamic,
    dynamic,
  )? onAddIngredient;

  const AddIngredientReceiptEditButton({
    super.key,
    this.ingredientName,
    this.ingredientQuantity,
    this.ingredientPrice,
    this.ingredientIdsAndNames,
    this.index,
    this.onAddIngredient,
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
              index: index != null ? index! - 1 : 0,
              ingredientIdsAndNames: ingredientIdsAndNames ?? [],
              onAddIngredient: onAddIngredient,
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

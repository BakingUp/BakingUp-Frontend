import 'package:bakingup_frontend/screens/edit_ingredient_screen.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailEditStockButton extends StatelessWidget {
  final String ingredientId;
  final VoidCallback fetchIngredientList;
  const IngredientStockDetailEditStockButton({
    super.key,
    required this.ingredientId,
    required this.fetchIngredientList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Image.asset('assets/icons/edit.png'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditIngredientScreen(ingredientId: ingredientId),
            ),
          ).then((value) => fetchIngredientList());
        });
  }
}

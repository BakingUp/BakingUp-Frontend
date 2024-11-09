import 'package:bakingup_frontend/screens/edit_stock_screen.dart';
import 'package:flutter/material.dart';

class StockDetailEditStockButton extends StatelessWidget {
  final String recipeId;
  final VoidCallback fetchStockDetails;
  const StockDetailEditStockButton({
    super.key,
    required this.recipeId,
    required this.fetchStockDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditStockScreen(recipeId: recipeId),
          ),
        ).then(
          (value) {
            fetchStockDetails();
          },
        );
      },
      child: Image.asset('assets/icons/edit.png'),
    );
  }
}

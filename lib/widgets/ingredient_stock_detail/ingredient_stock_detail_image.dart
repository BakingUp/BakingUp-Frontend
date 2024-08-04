import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailImage extends StatelessWidget {
  const IngredientStockDetailImage({super.key});
  final ingredientUrl = "https://i.imgur.com/RLsjqFm.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor,
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: Image.network(
        ingredientUrl,
        width: MediaQuery.of(context)
            .size
            .width, // Make the image take all the width
        fit: BoxFit.cover,
      ),
    );
  }
}

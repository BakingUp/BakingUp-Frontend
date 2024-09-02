import 'package:flutter/material.dart';

class IngredientStockDetailImage extends StatelessWidget {
  final bool isLoading;
  const IngredientStockDetailImage({
    super.key,
    required this.isLoading,
  });
  final ingredientUrl = "https://i.imgur.com/RLsjqFm.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: !isLoading
          ? Image.network(
              ingredientUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }
}

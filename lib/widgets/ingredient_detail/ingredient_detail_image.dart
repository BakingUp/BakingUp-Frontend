import 'package:flutter/widgets.dart';

class IngredientDetailImage extends StatelessWidget {
  final String ingredientUrl;

  const IngredientDetailImage({super.key, required this.ingredientUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      ingredientUrl,
      width: MediaQuery.of(context)
          .size
          .width, // Make the image take all the width
      fit: BoxFit.cover,
    );
  }
}
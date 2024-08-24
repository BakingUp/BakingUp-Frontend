import 'package:flutter/widgets.dart';

class RecipeDetailImage extends StatelessWidget {
  final String recipeUrl;

  const RecipeDetailImage({super.key, required this.recipeUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      recipeUrl,
      width: MediaQuery.of(context)
          .size
          .width,
      fit: BoxFit.cover,
    );
  }
}

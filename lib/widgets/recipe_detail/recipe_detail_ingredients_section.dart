import 'package:bakingup_frontend/screens/add_edit_recipe_screen.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_ingredient_detail.dart';
import 'package:flutter/material.dart';

class RecipeDetailIngredientsSection extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  const RecipeDetailIngredientsSection(
      {super.key, required this.recipeIngredients});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: recipeIngredients.length,
        itemBuilder: (context, index) {
          return RecipeDetailIngredientDetail(
            recipeIngredients: recipeIngredients,
            index: index,
          );
        },
      ),
    );
  }
}
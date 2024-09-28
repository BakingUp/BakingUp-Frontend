
import 'package:bakingup_frontend/models/recipe_detail.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_ingredient_detail.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_ingredient_detail_loading.dart';
import 'package:flutter/material.dart';

class RecipeDetailIngredientsSection extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final bool isLoading;
  const RecipeDetailIngredientsSection({
    super.key,
    required this.recipeIngredients,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const RecipeDetailIngredientDetailLoading();
              },
            ),
          )
        : Expanded(
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

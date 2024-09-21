import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/recipe_detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailIngredientDetail extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final int index;

  const RecipeDetailIngredientDetail(
      {super.key, required this.recipeIngredients, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      recipeIngredients[index].ingredientUrl,
                      width: 80,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 12.0)),
                  Text(
                    recipeIngredients[index].ingredientName,
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    recipeIngredients[index].ingredientQuantity,
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8.0)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

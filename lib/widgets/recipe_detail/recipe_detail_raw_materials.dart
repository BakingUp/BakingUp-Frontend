import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/recipe_detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailRawMaterials extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final bool isLoading;
  const RecipeDetailRawMaterials({
    super.key,
    required this.recipeIngredients,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: recipeIngredients.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 36),
                Text(
                  "• ",
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: 100,
                          height: 15,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 6.0),
                        ),
                      )
                    : Text(
                        recipeIngredients[index].ingredientName,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
              ],
            ),
            Row(
              children: [
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: 100,
                          height: 15,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 6.0),
                        ),
                      )
                    : Text(
                        recipeIngredients[index].ingredientPrice == -1
                            ? "- ฿"
                            : "${recipeIngredients[index].ingredientPrice} ฿",
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                const SizedBox(width: 30),
              ],
            ),
          ],
        );
      },
    );
  }
}

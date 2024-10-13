import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/screens/recipe_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WarehouseRecipesItem extends StatelessWidget {
  final List<RecipeItemData> recipeList;
  final int index;
  final bool isLoading;

  const WarehouseRecipesItem(
      {super.key,
      required this.recipeList,
      required this.index,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RecipeDetailScreen(recipeId: recipeList[index].recipeID)));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
        decoration: BoxDecoration(
          color: beigeColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    width: 90,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.network(
                    recipeList[index].recipeImg,
                    width: 90,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/icons/no-image.jpg',
                        width: 90,
                        height: 60,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipeList[index].recipeName,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              i < recipeList[index].stars
                                  ? Icons.star
                                  : Icons.star_border,
                              color: i < recipeList[index].stars
                                  ? orangeColor
                                  : greyColor,
                              size: 12,
                            ),
                          const SizedBox(width: 1),
                          Text(
                            "(${recipeList[index].numOfOrder})",
                            style: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total Time: ${recipeList[index].totalTime}',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Servings: ${recipeList[index].servings}',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

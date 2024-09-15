import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngredientStockDetailIngredientName extends StatelessWidget {
  final bool isLoading;
  final String ingredientEngName;
  final String ingredientThaiName;
  const IngredientStockDetailIngredientName({
    super.key,
    required this.isLoading,
    required this.ingredientEngName,
    required this.ingredientThaiName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoading
            ? Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 134,
                  height: 16,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 3.0),
                ),
              )
            : const Text(
                'Ingredient Name:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 100,
                      height: 16,
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 3.0),
                    ),
                  )
                : Text(
                    ingredientEngName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
            const SizedBox(height: 8),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 100,
                      height: 16,
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 7.0),
                    ),
                  )
                : Text(
                    ingredientThaiName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}

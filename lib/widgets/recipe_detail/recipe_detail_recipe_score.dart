import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailRecipeScore extends StatelessWidget {
  final int score;
  final int star;
  final bool isLoading;
  const RecipeDetailRecipeScore({
    super.key,
    required this.score,
    required this.star,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 120,
              height: 20,
              color: Colors.white,
            ),
          )
        : Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  i < star ? Icons.star : Icons.star_border,
                  color: i < star ? orangeColor : greyColor,
                  size: 16,
                ),
              const SizedBox(width: 5.0),
              Text(
                "($score)",
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          );
  }
}

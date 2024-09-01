import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailServings extends StatelessWidget {
  final int servings;
  final bool isLoading;
  const RecipeDetailServings({
    super.key,
    required this.servings,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 70,
              height: 13,
              color: Colors.white,
              margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
            ),
          )
        : Text(
            'Servings: $servings',
            style: TextStyle(
              color: blackColor,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              fontSize: 13,
            ),
          );
  }
}

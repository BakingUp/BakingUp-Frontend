import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailRecipeName extends StatelessWidget {
  final String recipeName;
  final bool isLoading;
  const RecipeDetailRecipeName({
    super.key,
    required this.recipeName,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 150,
              height: 30,
              color: Colors.white,
              margin: const EdgeInsets.only(top: 4.0),
            ),
          )
        : Text(
            recipeName,
            style: TextStyle(
              color: blackColor,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          );
  }
}

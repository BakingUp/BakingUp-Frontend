import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailHiddenCosts extends StatelessWidget {
  final bool isLoading;
  const RecipeDetailHiddenCosts({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 50,
              height: 16,
              color: Colors.white,
            ),
          )
        : const Text(
            '12.8 ฿',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}

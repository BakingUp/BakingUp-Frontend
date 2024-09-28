import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailLaborCosts extends StatelessWidget {
  final bool isLoading;
  const RecipeDetailLaborCosts({
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
            '250 ฿',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}

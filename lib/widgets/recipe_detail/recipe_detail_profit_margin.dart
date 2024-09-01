import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailProfitMargin extends StatelessWidget {
  final bool isLoading;
  const RecipeDetailProfitMargin({
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
            '117.24 ฿',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}

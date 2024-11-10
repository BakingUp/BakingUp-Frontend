import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailHiddenCosts extends StatelessWidget {
  final bool isLoading;
  final double hiddenCost;
  const RecipeDetailHiddenCosts({
    super.key,
    required this.isLoading,
    required this.hiddenCost,
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
        : Text(
            "${hiddenCost == -1 ? "-" : NumberFormat('#,##0.00').format(hiddenCost).replaceAll(removeTrailingZeros, '')} ฿",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}

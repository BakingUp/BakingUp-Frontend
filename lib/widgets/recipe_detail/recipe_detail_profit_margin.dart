import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailProfitMargin extends StatelessWidget {
  final bool isLoading;
  final double profitMargin;
  const RecipeDetailProfitMargin({
    super.key,
    required this.isLoading,
    required this.profitMargin,
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
            '${profitMargin == -1 ? "-" : NumberFormat('#,##0.00').format(profitMargin).replaceAll(removeTrailingZeros, '')} ฿',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}

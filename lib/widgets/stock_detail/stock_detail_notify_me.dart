import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailNotifyMe extends StatelessWidget {
  final double ingredientLessThan;
  final bool isLoading;

  const StockDetailNotifyMe({
    super.key,
    required this.ingredientLessThan,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 130,
              height: 15,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 4.0),
            ),
          )
        : Text(
            'Notify me : < ${ingredientLessThan.toString().replaceAll(removeTrailingZeros, '')} unit',
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

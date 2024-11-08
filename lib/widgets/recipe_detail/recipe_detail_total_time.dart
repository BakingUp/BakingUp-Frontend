import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailTotalTime extends StatelessWidget {
  final String totalTime;
  final bool isLoading;
  final int servings;
  final bool isScaled;

  const RecipeDetailTotalTime({
    super.key,
    required this.totalTime,
    required this.isLoading,
    required this.servings,
    required this.isScaled,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 150,
              height: 13,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 4.0),
            ),
          )
        : Row(
            children: [
              Text(
                'Total Time: $totalTime ',
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
              isScaled
                  ? Text(
                      '(Servings: $servings)',
                      style: TextStyle(
                        color: redColor,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    )
                  : Container(),
            ],
          );
  }
}

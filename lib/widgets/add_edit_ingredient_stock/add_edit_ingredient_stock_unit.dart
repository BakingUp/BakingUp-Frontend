import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddEditIngredientStockUnit extends StatelessWidget {
  final String text;
  final bool? isLoading;
  const AddEditIngredientStockUnit({
    super.key,
    required this.text,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading!
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              height: 45,
              width: 50,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        : Container(
            height: 45,
            width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${text.toLowerCase()}.",
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
  }
}

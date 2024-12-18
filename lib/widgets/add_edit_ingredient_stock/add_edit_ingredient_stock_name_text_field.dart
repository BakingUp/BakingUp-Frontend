import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddEditIngredientStockNameTextField extends StatelessWidget {
  final String text;
  final bool isLoading;
  const AddEditIngredientStockNameTextField({
    super.key,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        : Container(
            height: 45,
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
  }
}

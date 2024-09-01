import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailIngredientDetailLoading extends StatelessWidget {
  const RecipeDetailIngredientDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 12.0)),
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 4.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 50,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 8.0)),
            ],
          )
        ],
      ),
    );
  }
}

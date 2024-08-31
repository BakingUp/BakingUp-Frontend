import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngredientDetailImage extends StatelessWidget {
  final String? ingredientUrl;
  final bool isLoading;

  const IngredientDetailImage({
    super.key,
    required this.ingredientUrl,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width / 0.8),
              color: Colors.white,
            ),
          ),
        ),
        if (isLoading == false) ...[
          Image.network(
            ingredientUrl!,
            width: MediaQuery.of(context)
                .size
                .width, // Make the image take all the width
            fit: BoxFit.cover,
          ),
        ]
      ],
    );
  }
}

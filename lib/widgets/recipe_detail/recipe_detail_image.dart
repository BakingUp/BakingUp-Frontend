import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailImage extends StatelessWidget {
  final String? recipeUrl;
  final bool isLoading;

  const RecipeDetailImage({
    super.key,
    required this.recipeUrl,
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
          if (recipeUrl != '') ...[
            Image.network(
              recipeUrl!,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ] else ...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width / 0.8),
              color: greyColor,
            )
          ]
        ]
      ],
    );
  }
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_edit_stock_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngredientDetailIngredientName extends StatelessWidget {
  final String ingredientName;
  final bool isLoading;

  const IngredientDetailIngredientName({
    super.key,
    required this.ingredientName,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 200,
              height: 30,
              color: Colors.white,
            ),
          )
        : Row(
            children: [
              Text(
                ingredientName,
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
              ),
              const IngredientStockDetailEditStockButton(),
            ],
          );
  }
}

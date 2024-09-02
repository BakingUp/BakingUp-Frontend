import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngredientStockDetailBrand extends StatelessWidget {
  final bool isLoading;
  const IngredientStockDetailBrand({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 100,
                  height: 16,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 7.0),
                ),
              ),
            ],
          )
        : const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Brand:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'KITE',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
  }
}

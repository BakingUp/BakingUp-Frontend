import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailPriceDetail extends StatelessWidget {
  final Color color;
  final String header;
  final double price;
  final bool isLoading;

  const RecipeDetailPriceDetail({
    super.key,
    required this.color,
    required this.header,
    required this.price,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 120,
          child: Text(
            header,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 30,
          child: isLoading
              ? Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 50,
                    height: 16,
                    color: Colors.white,
                  ),
                )
              : Text(
                  "$price ฿",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      ],
    );
  }
}

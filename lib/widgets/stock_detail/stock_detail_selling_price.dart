import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailSellingPrice extends StatelessWidget {
  final double price;
  final bool isLoading;

  const StockDetailSellingPrice({
    super.key,
    required this.price,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 120,
              height: 15,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 4.0),
            ),
          )
        : Text(
            'Selling price : ${price.toString().replaceAll(removeTrailingZeros, '')} ฿',
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

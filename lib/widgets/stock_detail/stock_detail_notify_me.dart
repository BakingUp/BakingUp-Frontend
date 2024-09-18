import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailNotifyMe extends StatelessWidget {
  final int stockLessThan;
  final bool isLoading;

  const StockDetailNotifyMe({
    super.key,
    required this.stockLessThan,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 130,
              height: 15,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 4.0),
            ),
          )
        : Text(
            'Notify me : < ${stockLessThan.toString()} unit',
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

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailLst extends StatelessWidget {
  final int lst;
  final bool isLoading;

  const StockDetailLst({
    super.key,
    required this.lst,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 50,
              height: 15,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 4.0),
            ),
          )
        : Text(
            'LST: ${lst.toString()}',
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

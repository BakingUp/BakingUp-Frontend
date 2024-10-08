import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockItemLoading extends StatelessWidget {
  const StockItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        color: beigeColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    width: 90,
                    height: 60,
                    color: Colors.white,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 16.0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: greyColor,
                      highlightColor: whiteColor,
                      child: Container(
                        width: 60,
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                    ),
                    Shimmer.fromColors(
                      baseColor: greyColor,
                      highlightColor: whiteColor,
                      child: Container(
                        width: 80,
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 1.0),
                    ),
                    Shimmer.fromColors(
                      baseColor: greyColor,
                      highlightColor: whiteColor,
                      child: Container(
                        width: 60,
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 40,
              height: 100,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(13),
                      bottomRight: Radius.circular(13)),
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

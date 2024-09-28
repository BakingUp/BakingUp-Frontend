import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailDetailLoading extends StatelessWidget {
  const StockDetailDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
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
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 20.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 100,
                      height: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 100,
                      height: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

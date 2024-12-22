import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductionDetailLoading extends StatelessWidget {
  const ProductionDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      decoration: BoxDecoration(
        color: pinkColor,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Container(
                    width: 90,
                    height: 60,
                    color: greyColor, 
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 16.0)),
            ],
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    width: 120,
                    height: 12,
                    color: greyColor, 
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 12,
                        color: greyColor,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: 80,
                          height: 12,
                          color: greyColor, 
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    width: 120,
                    height: 12,
                    color: greyColor, 
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 20.0))
        ],
      ),
    );
  }
}
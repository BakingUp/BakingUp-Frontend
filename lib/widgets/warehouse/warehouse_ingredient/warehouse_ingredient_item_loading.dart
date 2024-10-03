import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WarehouseIngredientsItemLoading extends StatelessWidget {
  const WarehouseIngredientsItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
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
                  width: 90,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white),
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
                      width: 50,
                      height: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            ],
          )
        ],
      ),
    );
  }
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngredientStockDetailLoading extends StatelessWidget {
  const IngredientStockDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      padding: const EdgeInsets.all(12.0),
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
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 12.0)),
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
                      margin: const EdgeInsets.only(bottom: 4.0),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 70,
                      height: 10,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 4.0),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 120,
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
              Image.asset(
                'assets/icons/edit.png',
                scale: 0.7,
              ),
              const Padding(padding: EdgeInsets.only(right: 8.0)),
            ],
          )
        ],
      ),
    );
  }
}

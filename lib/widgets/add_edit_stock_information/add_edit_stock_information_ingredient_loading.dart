import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddEditStockInformationIngredientLoading extends StatelessWidget {
  const AddEditStockInformationIngredientLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 15),
      width: MediaQuery.of(context).size.width - 82,
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
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 12.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      width: 60,
                      height: 10,
                      margin: const EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                    ),
                  )
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
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

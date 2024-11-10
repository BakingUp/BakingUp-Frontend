import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddIngredientReceiptIngredientDetailLoading extends StatelessWidget {
  final int index;

  const AddIngredientReceiptIngredientDetailLoading(
      {super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(21, 16, 21, 16),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#$index",
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: darkGreyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: darkGreyColor,
                            highlightColor: whiteColor,
                            child: Container(
                              height: 15,
                              width: 50,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          Shimmer.fromColors(
                            baseColor: darkGreyColor,
                            highlightColor: whiteColor,
                            child: Container(
                              height: 15,
                              width: 50,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const AddIngredientReceiptEditButton(),
            ],
          ),
        ],
      ),
    );
  }
}

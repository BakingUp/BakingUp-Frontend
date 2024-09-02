import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_delete_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class IngredientStockDetailNoteDetailLoading extends StatelessWidget {
  const IngredientStockDetailNoteDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 16),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: beigeColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    width: 120,
                    height: 13,
                    color: Colors.white,
                    margin: const EdgeInsets.fromLTRB(0, 0, 10.0, 6.0),
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IngredientStockDetailDeleteButton(
                        dialogParams: BakingUpDialogParams(
                          title: "Confirm Delete?",
                          imgUrl: "assets/icons/delete_warning.png",
                          content:
                              "This will permanently delete the note. Are you sure you want to proceed?",
                          grayButtonTitle: "Cancel",
                          secondButtonTitle: "Delete",
                          secondButtonColor: lightRedColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align the second row to the right
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 80,
                  height: 13,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 6.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

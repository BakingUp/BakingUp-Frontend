import 'package:bakingup_frontend/screens/ingredient_stock_detail_screen.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_delete_button.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailNoteDetail extends StatelessWidget {
  final List<IngredientStockDetailNote> ingredientStockDetailNotes;
  final int index;

  const IngredientStockDetailNoteDetail(
      {super.key,
      required this.ingredientStockDetailNotes,
      required this.index});

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
              Flexible(
                child: Text(
                  ingredientStockDetailNotes[index].ingredientNote,
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
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
              Text(
                ingredientStockDetailNotes[index].noteCreatedAt,
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

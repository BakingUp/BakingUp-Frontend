import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/get_all_ingredient_ids_and_names.dart';
import 'package:bakingup_frontend/screens/add_ingredient_receipt_screen.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_edit_button.dart';
import 'package:flutter/material.dart';

class AddIngredientReceiptIngredientDetail extends StatelessWidget {
  final IngredientDetail ingredientDetail;
  final int index;
  final List<Ingredient> ingredientIdsAndNames;
  final Function(
    dynamic,
    dynamic,
    dynamic,
    dynamic,
  ) onAddIngredient;

  const AddIngredientReceiptIngredientDetail({
    super.key,
    required this.ingredientDetail,
    required this.index,
    required this.ingredientIdsAndNames,
    required this.onAddIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.fromLTRB(21, 16, 21, 16),
      decoration: BoxDecoration(
        color: ingredientDetail.isEdited ? beigeColor : greyColor,
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
                      Text(
                        ingredientDetail.ingredientName,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          Text(
                            'Quantity: ${ingredientDetail.ingredientQuantity}',
                            style: TextStyle(
                              color: blackColor,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                              width: 100 -
                                  'Quantity: ${ingredientDetail.ingredientQuantity}'
                                          .length *
                                      6), // Adjust the width to account for the text width
                          Text(
                            'Price: ${ingredientDetail.ingredientPrice}',
                            style: TextStyle(
                              color: blackColor,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              !ingredientDetail.isEdited
                  ? AddIngredientReceiptEditButton(
                      ingredientName: ingredientDetail.ingredientName,
                      ingredientQuantity: ingredientDetail.ingredientQuantity,
                      ingredientPrice: ingredientDetail.ingredientPrice,
                      ingredientIdsAndNames: ingredientIdsAndNames,
                      index: index,
                      onAddIngredient: onAddIngredient,
                    )
                  : Icon(
                      Icons.check,
                      color: blackColor,
                      size: 30,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:bakingup_frontend/screens/add_edit_recipe_ingredient_screen.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/expiration_status_indicator.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditRecipeIngredientDetail extends StatelessWidget {
  final List<RecipeIngredientDetail> recipeIngredientDetails;
  final int index;

  const AddEditRecipeIngredientDetail(
      {super.key, required this.recipeIngredientDetails, required this.index});

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
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  recipeIngredientDetails[index].imgUrl,
                  width: 90,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 16.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeIngredientDetails[index].name,
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                  ),
                  Text(
                    'Quantity: ${recipeIngredientDetails[index].quantity}',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 1.0),
                  ),
                  Text(
                    '${recipeIngredientDetails[index].stock} ${recipeIngredientDetails[index].stock > 1 ? "stocks" : "stock"}',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ExpirationStatusIndicator(
                  status: recipeIngredientDetails[index].expirationStatus),
              const Padding(padding: EdgeInsets.only(right: 20.0)),
            ],
          )
        ],
      ),
    );
  }
}

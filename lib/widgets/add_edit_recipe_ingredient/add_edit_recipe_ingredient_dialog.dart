import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_recipe_ingredient_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddEditRecipeIngredientDialog extends StatelessWidget {
  final String ingredientTitle;
  final String imgUrl;
  final String unit;

  const AddEditRecipeIngredientDialog({
    super.key,
    required this.ingredientTitle,
    required this.imgUrl,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Adding Ingredient",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.network(
                    "${dotenv.env['API_BASE_URL']}/$imgUrl",
                    width: 90,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      ingredientTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '*',
                  style: TextStyle(
                    color: redColor,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 16),
                const AddEditRecipeIngredientTextField(
                    label: "Quantity", width: 80),
                const SizedBox(width: 16),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                    title: "Cancel", color: greyColor, width: 120),
                const SizedBox(width: 8),
                BakingUpLongActionButton(
                    title: "Confirm", color: lightGreenColor, width: 120),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddEditRecipeIngredientDialogParams {
  final String ingredientTitle;
  final String imgUrl;

  AddEditRecipeIngredientDialogParams({
    required this.ingredientTitle,
    required this.imgUrl,
  });
}

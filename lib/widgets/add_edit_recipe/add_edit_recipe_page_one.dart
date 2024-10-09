import 'dart:io';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_screen.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_ingredient.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';

class AddEditRecipePageOne extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final List<File> recipeImages;
  final VoidCallback onClick;
  final Function(File) onNewImage;
  const AddEditRecipePageOne({
    super.key,
    required this.recipeIngredients,
    required this.recipeImages,
    required this.onClick,
    required this.onNewImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddEditRecipeTitle(title: "Recipe Information"),
        BakingUpImagePicker(images: recipeImages, onNewImage: onNewImage),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Recipe Name',
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
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AddEditRecipeNameTextField(label: 'English'),
                SizedBox(height: 16),
                AddEditRecipeNameTextField(label: 'Thai')
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Total Time',
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
            const AddEditRecipeTextField(label: "Hr", width: 46),
            const SizedBox(width: 16),
            const Text(
              'hrs.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16),
            const AddEditRecipeTextField(label: "Min", width: 46),
            const SizedBox(width: 16),
            const Text(
              'mins.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Servings',
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
            const AddEditRecipeTextField(label: "Servings", width: 150)
          ],
        ),
        const SizedBox(height: 50),
        Stack(
          children: [
            const Align(
              alignment: Alignment.center,
              child: AddEditRecipeTitle(
                title: "Ingredients",
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              heightFactor: 0.5,
              child: BakingUpCircularAddButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEditRecipeIngredientScreen(),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: recipeIngredients.length,
            itemBuilder: (context, index) {
              return AddEditRecipeIngredient(
                recipeIngredients: recipeIngredients,
                index: index,
              );
            }),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BakingUpLongActionButton(
                title: 'Next', color: greyColor, onClick: onClick),
          ],
        )
      ],
    );
  }
}

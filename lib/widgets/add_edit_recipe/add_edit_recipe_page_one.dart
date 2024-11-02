import 'dart:io';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_edit_recipe_controller.dart';
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
  final Function(int) onImgDelete;
  final Function(String) onIngredientDelete;
  final AddEditRecipeController controller;
  final void Function(RecipeIngredient ingredient) addIngredient;
  const AddEditRecipePageOne({
    super.key,
    required this.recipeIngredients,
    required this.recipeImages,
    required this.onClick,
    required this.onNewImage,
    required this.onImgDelete,
    required this.onIngredientDelete,
    required this.controller,
    required this.addIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddEditRecipeTitle(title: "Recipe Information"),
        BakingUpImagePicker(
          images: recipeImages,
          onNewImage: onNewImage,
          isOneImage: false,
          onDelete: (index) {
            onImgDelete(index);
          },
        ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AddEditRecipeNameTextField(
                  label: 'English',
                  controller: controller.engNameController,
                ),
                const SizedBox(height: 16),
                AddEditRecipeNameTextField(
                  label: 'Thai',
                  controller: controller.thaiNameController,
                )
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
            AddEditRecipeTextField(
              label: "Hr",
              width: 46,
              controller: controller.totalHoursController,
            ),
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
            AddEditRecipeTextField(
              label: "Min",
              width: 46,
              controller: controller.totalMinsController,
            ),
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
            AddEditRecipeTextField(
              label: "Servings",
              width: 150,
              controller: controller.servingsController,
            )
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
              child: BakingUpCircularAddButton(onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditRecipeIngredientScreen(
                      recipeIngredients: recipeIngredients,
                      addIngredient: addIngredient,
                    ),
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
              return Dismissible(
                key: Key(recipeIngredients[index].id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: redColor,
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                confirmDismiss: (direction) async {
                  onIngredientDelete(recipeIngredients[index].id);
                },
                child: AddEditRecipeIngredient(
                  recipeIngredients: recipeIngredients,
                  index: index,
                ),
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

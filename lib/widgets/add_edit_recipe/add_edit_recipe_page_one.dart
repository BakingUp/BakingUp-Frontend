import 'dart:io';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_edit_recipe_controller.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_recipe_screen.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_ingredient.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_ingredient_loading.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddEditRecipePageOne extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final List<File> recipeImages;
  final VoidCallback onClick;
  final Function(File) onNewImage;
  final Function(int) onImgDelete;
  final Function(String) onIngredientDelete;
  final AddEditRecipeController controller;
  final FocusNode recipeNameFocusNode;
  final FocusNode totalHoursFocusNode;
  final FocusNode totalMinsFocusNode;
  final FocusNode servingsFocusNode;
  final void Function(RecipeIngredient ingredient) addIngredient;
  final bool? isEdit;
  final bool? isLoading;
  const AddEditRecipePageOne({
    super.key,
    required this.recipeIngredients,
    required this.recipeImages,
    required this.onClick,
    required this.onNewImage,
    required this.onImgDelete,
    required this.onIngredientDelete,
    required this.controller,
    required this.recipeNameFocusNode,
    required this.totalHoursFocusNode,
    required this.totalMinsFocusNode,
    required this.servingsFocusNode,
    required this.addIngredient,
    this.isEdit,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddEditRecipeTitle(title: "Recipe Information"),
        isEdit == null || !isEdit!
            ? BakingUpImagePicker(
                images: recipeImages,
                onNewImage: onNewImage,
                isOneImage: false,
                onDelete: (index) {
                  onImgDelete(index);
                },
              )
            : Container(),
        SizedBox(height: isEdit != null && isEdit! ? 24 : 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
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
                const SizedBox(height: 8),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isLoading != null && isLoading!
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditRecipeNameTextField(
                        label: 'Recipe Name',
                        controller: controller.engNameController,
                        focusNode: recipeNameFocusNode,
                      ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
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
            isLoading != null && isLoading!
                ? Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      height: 45,
                      width: 46,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : AddEditRecipeTextField(
                    label: "Hr",
                    width: 46,
                    controller: controller.totalHoursController,
                    focusNode: totalHoursFocusNode,
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
            isLoading != null && isLoading!
                ? Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      height: 45,
                      width: 46,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : AddEditRecipeTextField(
                    label: "Min",
                    width: 46,
                    controller: controller.totalMinsController,
                    focusNode: totalMinsFocusNode,
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
            isLoading != null && isLoading!
                ? Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: whiteColor,
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : AddEditRecipeTextField(
                    label: "Servings",
                    width: 150,
                    controller: controller.servingsController,
                    focusNode: servingsFocusNode,
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
            isLoading == null || !isLoading!
                ? Align(
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
                  )
                : Container(),
          ],
        ),
        const SizedBox(height: 24),
        isLoading != null && isLoading!
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const AddEditRecipeIngredientLoading();
                })
            : ListView.builder(
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
                      return onIngredientDelete(recipeIngredients[index].id);
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
              title: 'Next',
              color: greyColor,
              onClick: onClick,
              isDisabled: false,
            ),
          ],
        )
      ],
    );
  }
}

import 'dart:io';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_edit_recipe_controller.dart';
import 'package:bakingup_frontend/screens/add_recipe_screen.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_instruction_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddEditRecipePageTwo extends StatelessWidget {
  final VoidCallback onClick;
  final List<File> instructionImages;
  final bool isEdit;
  final Function(File) onNewImage;
  final Function(int) onImgDelete;
  final VoidCallback onSave;
  final FocusNode instructionFocusNode;
  final AddEditRecipeController controller;
  final List<RecipeIngredient> recipeIngredients;
  final bool? isLoading;
  const AddEditRecipePageTwo({
    super.key,
    required this.onClick,
    required this.instructionImages,
    required this.isEdit,
    required this.onNewImage,
    required this.onImgDelete,
    required this.onSave,
    required this.instructionFocusNode,
    required this.controller,
    required this.recipeIngredients,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddEditRecipeTitle(title: "Instructions"),
        !isEdit
            ? BakingUpImagePicker(
                images: instructionImages,
                onNewImage: onNewImage,
                isOneImage: false,
                onDelete: (index) {
                  onImgDelete(index);
                },
              )
            : Container(),
        SizedBox(height: isEdit ? 24 : 16),
        const AddEditRecipeTitle(
          title: "Instruction detail :",
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 16),
        isLoading != null && isLoading!
            ? Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  height: 87,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            : AddEditRecipeInstructionField(
                label: 'Instructions',
                controller: controller.engInstructionController,
                focusNode: instructionFocusNode,
              ),
        const SizedBox(height: 30),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BakingUpLongActionButton(
              title: 'Back',
              color: greyColor,
              onClick: onClick,
              isDisabled: false,
            ),
            const SizedBox(width: 8),
            BakingUpLongActionButton(
              title: 'Save',
              color: controller.totalHoursController.text.isEmpty ||
                      controller.totalMinsController.text.isEmpty ||
                      controller.servingsController.text.isEmpty ||
                      recipeIngredients.isEmpty
                  ? greyColor
                  : lightGreenColor,
              isDisabled: controller.totalHoursController.text.isEmpty ||
                  controller.totalMinsController.text.isEmpty ||
                  controller.servingsController.text.isEmpty ||
                  recipeIngredients.isEmpty,
              dialogParams: BakingUpDialogParams(
                title: isEdit
                    ? 'Confirm Recipe Changes?'
                    : 'Confirm Adding Recipe?',
                imgUrl: 'assets/icons/warning.png',
                content: isEdit
                    ? 'You\'re about to save edited recipe data to the warehouse.'
                    : 'You\'re about to add new recipe data to the warehouse.',
                grayButtonTitle: 'Cancel',
                secondButtonTitle: 'Confirm',
                secondButtonColor: lightGreenColor,
                secondButtonOnClick: onSave,
              ),
            ),
          ],
        )
      ],
    );
  }
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_instruction_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';

class AddEditRecipePageTwo extends StatelessWidget {
  final VoidCallback onClick;
  final bool isEdit;
  const AddEditRecipePageTwo(
      {super.key, required this.onClick, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddEditRecipeTitle(title: "Instructions"),
        const BakingUpImagePicker(),
        const SizedBox(height: 16),
        const AddEditRecipeTitle(
          title: "Instruction detail :",
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 16),
        const AddEditRecipeInstructionField(label: 'English'),
        const SizedBox(height: 30),
        const AddEditRecipeInstructionField(label: 'Thai'),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BakingUpLongActionButton(
                title: 'Back', color: greyColor, onClick: onClick),
            const SizedBox(width: 8),
            BakingUpLongActionButton(
              title: 'Save',
              color: lightGreenColor,
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
              ),
            ),
          ],
        )
      ],
    );
  }
}

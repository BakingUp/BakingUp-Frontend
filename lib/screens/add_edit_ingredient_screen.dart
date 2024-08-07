// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_image_uploader.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_notification_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';

class AddEditIngredientScreen extends StatefulWidget {
  const AddEditIngredientScreen({super.key});

  @override
  State<AddEditIngredientScreen> createState() =>
      _AddEditIngredientScreenState();
}

class _AddEditIngredientScreenState extends State<AddEditIngredientScreen> {
  final int _currentDrawerIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Ingredient",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      body: AddEditIngredientContainer(
        children: [
          const AddEditIngredientTitle(title: "Ingredient Information"),
          const AddEditIngredientImageUploader(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Ingredient Name',
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
                  AddEditIngredientNameTextField(label: 'English'),
                  SizedBox(height: 16),
                  AddEditIngredientNameTextField(label: 'Thai')
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Row(
                children: [
                  const Text(
                    'Unit',
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
              const SizedBox(width: 8),
              const BakingUpDropdown(text: 'select')
            ],
          ),
          const SizedBox(height: 50),
          const AddEditIngredientTitle(title: "Notification Setting"),
          const SizedBox(height: 16),
          const Row(
            children: [
              Flexible(
                child: Text(
                  'Notify me when an ingredient falls below',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              AddEditIngredientNotificationTextField(),
              Text(
                'unit',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Text(
                'Notify me',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BakingUpDropdown(text: 'select'),
              ),
              Text(
                'days before expiration',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BakingUpLongActionButton(title: 'Cancel', color: greyColor),
              const SizedBox(width: 8),
              BakingUpLongActionButton(
                title: 'Save',
                color: lightGreenColor,
                dialogParams: BakingUpDialogParams(
                  title: 'Confirm Adding Ingredient?',
                  imgUrl: 'assets/icons/warning.png',
                  content:
                      'You\'re about to add new ingredient data to the database.',
                  grayButtonTitle: 'Cancel',
                  secondButtonTitle: 'Confirm',
                  secondButtonColor: lightGreenColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

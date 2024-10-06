// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_delete_button.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_expiration_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_note_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_image_uploader.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';

class AddEditIngredientStockScreen extends StatefulWidget {
  const AddEditIngredientStockScreen({super.key});

  @override
  State<AddEditIngredientStockScreen> createState() =>
      _AddEditIngredientStockScreenState();
}

class _AddEditIngredientStockScreenState
    extends State<AddEditIngredientStockScreen> {
  final bool _isEdit = false;
  List<IngredientStockDetailNote> ingredientStockDetailNotes = [
    IngredientStockDetailNote(
      ingredientNote: "This ingredient is used for making bread.",
      noteCreatedAt: "03/03/2024",
    ),
    IngredientStockDetailNote(
      ingredientNote: "This ingredient is used for making cake.",
      noteCreatedAt: "06/03/2024",
    ),
    IngredientStockDetailNote(
      ingredientNote: "This ingredient is used for making cookies.",
      noteCreatedAt: "09/03/2024",
    ),
  ];

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
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: AddEditIngredientStockContainer(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AddEditIngredientStockTitle(
                  title: "Ingredient Information"),
              AddEditIngredientStockDeleteButton(
                dialogParams: BakingUpDialogParams(
                  title: "Confirm Delete?",
                  imgUrl: "assets/icons/delete_warning.png",
                  content: "Are you sure you want to delete this ingredient?",
                  grayButtonTitle: "Cancel",
                  secondButtonTitle: "Delete",
                  secondButtonColor: lightRedColor,
                ),
              ),
            ],
          ),
          const AddEditIngredientStockImageUploader(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  const SizedBox(width: 16),
                ],
              ),
              const Column(
                children: [
                  AddEditIngredientStockNameTextField(label: 'English'),
                  SizedBox(height: 16),
                  AddEditIngredientStockNameTextField(label: 'Thai')
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Brand',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 16),
              AddEditIngredientStockTextField(label: "Brand", width: 150)
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  AddEditIngredientStockTextField(
                      label: 'Quantity',
                      width: MediaQuery.of(context).size.width - 275),
                  const SizedBox(width: 16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(width: 8),
                  const BakingUpDropdown(text: 'select'),
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
                'Price',
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
              const AddEditIngredientStockTextField(label: "Price", width: 150)
            ],
          ),
          const SizedBox(height: 16),
          const AddEditIngredientStockTitle(title: "Additional Information"),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Supplier',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 16),
              AddEditIngredientStockTextField(label: "Supplier", width: 150)
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    'Expiration Date',
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
                ],
              ),
              const AddEditIngredientStockExpirationDateField(),
            ],
          ),
          const SizedBox(height: 50),
          const AddEditIngredientStockTitle(title: "Note:"),
          const SizedBox(height: 16),
          const AddEditIngredientStockNoteTextField(),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BakingUpLongActionButton(
                title: 'Save',
                color: lightGreenColor,
                dialogParams: BakingUpDialogParams(
                  title: _isEdit
                      ? 'Confirm Ingredient Changes?'
                      : 'Confirm Adding Ingredient?',
                  imgUrl: 'assets/icons/warning.png',
                  content: _isEdit
                      ? 'You\'re about to save edited ingredient to the warehouse.'
                      : 'Are you sure to add a new ingredient to the warehouse?',
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

// Temporary class to simulate the data
class IngredientStockDetailNote {
  final String ingredientNote;
  final String noteCreatedAt;

  IngredientStockDetailNote({
    required this.ingredientNote,
    required this.noteCreatedAt,
  });
}

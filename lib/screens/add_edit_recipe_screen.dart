// Importing libraries
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_page_one.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_page_two.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/models/add_edit_recipe_controller.dart';

class AddEditRecipeScreen extends StatefulWidget {
  const AddEditRecipeScreen({super.key});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final int _currentDrawerIndex = 5;
  final bool _isEdit = false;
  bool _isFirstPage = true;
  final List<File> _recipeImages = [];
  final List<File> _instructionImages = [];
  final AddEditRecipeController controller = AddEditRecipeController();

  List<RecipeIngredient> recipeIngredients = [];

  List<String> convertFilesToBase64(List<File> files) {
    return files.map((file) {
      final bytes = file.readAsBytesSync();
      return base64Encode(bytes);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Recipe",
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
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      body: AddEditRecipeContainer(
        children: [
          if (_isFirstPage) ...[
            AddEditRecipePageOne(
              recipeIngredients: recipeIngredients,
              recipeImages: _recipeImages,
              controller: controller,
              onIngredientDelete: (ingredientId) {
                setState(() {
                  recipeIngredients
                      .removeWhere((element) => element.id == ingredientId);
                });
              },
              addIngredient: (RecipeIngredient ingredient) {
                setState(() {
                  recipeIngredients.add(
                    RecipeIngredient(
                      id: ingredient.id,
                      imgUrl: ingredient.imgUrl,
                      name: ingredient.name,
                      quantity: ingredient.quantity,
                      unit: ingredient.unit,
                    ),
                  );
                });
              },
              onClick: () {
                setState(() {
                  _isFirstPage = false;
                });
              },
              onNewImage: (File image) {
                setState(() {
                  _recipeImages.add(image);
                });
              },
              onImgDelete: (index) {
                setState(() {
                  _recipeImages.removeAt(index);
                });
              },
            ),
          ] else ...[
            AddEditRecipePageTwo(
              instructionImages: _instructionImages,
              controller: controller,
              onClick: () {
                setState(() {
                  _isFirstPage = true;
                });
              },
              isEdit: _isEdit,
              onNewImage: (File image) {
                setState(() {
                  _instructionImages.add(image);
                });
              },
              onImgDelete: (index) {
                setState(() {
                  _instructionImages.removeAt(index);
                });
              },
              onSave: () async {
                try {
                  final data = {
                    "user_id": "1",
                    "recipe_eng_name": controller.engNameController.text,
                    "recipe_thai_name": controller.thaiNameController.text,
                    "recipe_img": convertFilesToBase64(_recipeImages),
                    "total_hours": controller.totalHoursController.text,
                    "total_mins": controller.totalMinsController.text,
                    "servings": controller.servingsController.text,
                    "ingredients": recipeIngredients
                        .map((ingredient) => {
                              "ingredient_id": ingredient.id,
                              "ingredient_quantity": ingredient.quantity,
                            })
                        .toList(),
                    "instruction_img": convertFilesToBase64(_instructionImages),
                    "eng_instruction": controller.engInstructionController.text,
                    "thai_instruction":
                        controller.thaiInstructionController.text,
                  };
                  log(data.toString());
                  await NetworkService.instance
                      .post(
                    "/api/recipe/addRecipe",
                    data: data,
                  )
                      .then(
                    (value) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  );
                } catch (e) {
                  log(e.toString());
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).overlay!.insert(
                    OverlayEntry(
                      builder: (BuildContext context) {
                        return const BakingUpErrorTopNotification(
                          message:
                              "Sorry, we couldn’t add the recipe due to a system error. Please try again later.",
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ]
        ],
      ),
    );
  }
}

class RecipeIngredient {
  final String id;
  final String imgUrl;
  final String name;
  final String quantity;
  final String unit;

  RecipeIngredient({
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.quantity,
    required this.unit,
  });
}

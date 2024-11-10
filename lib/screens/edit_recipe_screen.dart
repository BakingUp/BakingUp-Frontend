// Importing libraries
import 'dart:developer';
import 'dart:io';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
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
import 'package:bakingup_frontend/models/get_edit_recipe_detail.dart';
import 'package:bakingup_frontend/screens/add_recipe_screen.dart';

class EditRecipeScreen extends StatefulWidget {
  final String? recipeId;
  const EditRecipeScreen({
    super.key,
    this.recipeId,
  });

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final int _currentDrawerIndex = 5;
  final bool _isEdit = true;
  bool _isFirstPage = true;
  final List<File> _recipeImages = [];
  final List<File> _instructionImages = [];
  final AddEditRecipeController controller = AddEditRecipeController();
  bool isLoading = false;
  bool isError = false;
  final FocusNode recipeNameFocusNode = FocusNode();
  final FocusNode totalHoursFocusNode = FocusNode();
  final FocusNode totalMinsFocusNode = FocusNode();
  final FocusNode servingsFocusNode = FocusNode();
  final FocusNode instructionFocusNode = FocusNode();

  List<RecipeIngredient> recipeIngredients = [];

  Future<void> _fetchRecipe() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/recipe/getEditRecipeDetail?recipe_id=${widget.recipeId}');
      log(response.toString());
      final getEditRecipeDetailResponse =
          GetEditRecipeDetailResponse.fromJson(response);
      final data = getEditRecipeDetailResponse.data;

      setState(() {
        controller.engNameController.text = data.recipeEngName;
        controller.thaiNameController.text = data.recipeThaiName;
        controller.totalHoursController.text = data.totalHours;
        controller.totalMinsController.text = data.totalMins;
        controller.servingsController.text = data.servings;
        controller.engInstructionController.text = data.engInstruction;
        controller.thaiInstructionController.text = data.thaiInstruction;
        recipeIngredients = data.ingredients.map((ingredient) {
          return RecipeIngredient(
            id: ingredient.ingredientId,
            imgUrl: ingredient.ingredientUrl,
            name: ingredient.ingredientName,
            quantity: ingredient.ingredientQuantity,
            unit: ingredient.ingredientUnit.toLowerCase(),
          );
        }).toList();
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        recipeNameFocusNode.unfocus();
        totalHoursFocusNode.unfocus();
        totalMinsFocusNode.unfocus();
        servingsFocusNode.unfocus();
        instructionFocusNode.unfocus();
      },
      child: Scaffold(
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
                isEdit: _isEdit,
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
                isLoading: isLoading,
                recipeNameFocusNode: recipeNameFocusNode,
                totalHoursFocusNode: totalHoursFocusNode,
                totalMinsFocusNode: totalMinsFocusNode,
                servingsFocusNode: servingsFocusNode,
              ),
            ] else ...[
              AddEditRecipePageTwo(
                isLoading: isLoading,
                instructionImages: _instructionImages,
                controller: controller,
                instructionFocusNode: instructionFocusNode,
                recipeIngredients: recipeIngredients,
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
                      "recipe_id": widget.recipeId,
                      "recipe_eng_name": controller.engNameController.text,
                      "recipe_thai_name": controller.thaiNameController.text,
                      "total_hours": controller.totalHoursController.text,
                      "total_mins": controller.totalMinsController.text,
                      "servings": controller.servingsController.text,
                      "ingredients": recipeIngredients
                          .map((ingredient) => {
                                "ingredient_id": ingredient.id,
                                "ingredient_quantity": ingredient.quantity,
                              })
                          .toList(),
                      "eng_instruction":
                          controller.engInstructionController.text,
                      "thai_instruction":
                          controller.thaiInstructionController.text,
                    };
                    log(data.toString());
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      barrierColor: const Color(0xC7D9D9D9),
                      builder: (BuildContext context) {
                        return const BakingUpLoadingDialog();
                      },
                    );
                    await NetworkService.instance
                        .put(
                      "/api/recipe/editRecipe",
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
      ),
    );
  }
}

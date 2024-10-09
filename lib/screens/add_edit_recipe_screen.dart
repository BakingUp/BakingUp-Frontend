// Importing libraries
import 'dart:io';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_page_one.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_page_two.dart';

class AddEditRecipeScreen extends StatefulWidget {
  const AddEditRecipeScreen({super.key});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final int _currentDrawerIndex = 5;
  final bool _isEdit = true;
  bool _isFirstPage = true;
  final List<File> _recipeImages = [];
  final List<File> _instructionImages = [];

  List<RecipeIngredient> recipeIngredients = [
    RecipeIngredient(
      imgUrl: "https://i.imgur.com/RLsjqFm.png",
      name: "All-purpose flour",
      quantity: "250 g",
    ),
    RecipeIngredient(
      imgUrl:
          "https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg",
      name: "Sugar",
      quantity: "150 g",
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
            ),
          ] else ...[
            AddEditRecipePageTwo(
              instructionImages: _instructionImages,
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
            ),
          ]
        ],
      ),
    );
  }
}

class RecipeIngredient {
  final String imgUrl;
  final String name;
  final String quantity;

  RecipeIngredient({
    required this.imgUrl,
    required this.name,
    required this.quantity,
  });
}

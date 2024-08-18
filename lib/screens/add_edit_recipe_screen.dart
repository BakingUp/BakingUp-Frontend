// Importing libraries
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_page_two.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_page_one.dart';

class AddEditRecipeScreen extends StatefulWidget {
  const AddEditRecipeScreen({super.key});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final int _currentDrawerIndex = 5;
  final bool _isEdit = true;
  bool _isFirstPage = true;

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
      body: AddEditRecipeContainer(
        children: [
          if (_isFirstPage) ...[
            AddEditRecipePageOne(
                recipeIngredients: recipeIngredients,
                onClick: () {
                  setState(() {
                    _isFirstPage = false;
                  });
                }),
          ] else ...[
            AddEditRecipePageTwo(
              onClick: () {
                setState(() {
                  _isFirstPage = true;
                });
              },
              isEdit: _isEdit,
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

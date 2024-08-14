// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_image_uploader.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe/add_edit_recipe_ingredient.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';

class AddEditRecipeScreen extends StatefulWidget {
  const AddEditRecipeScreen({super.key});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final int _currentDrawerIndex = 5;

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
          const AddEditRecipeTitle(title: "Recipe Information"),
          const AddEditRecipeImageUploader(),
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
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddEditRecipeNameTextField(label: 'English'),
                  SizedBox(height: 16),
                  AddEditRecipeNameTextField(label: 'Thai')
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
              const AddEditRecipeTextField(label: "Hr", width: 46),
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
              const AddEditRecipeTextField(label: "Min", width: 46),
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
              const AddEditRecipeTextField(label: "Servings", width: 150)
            ],
          ),
          const SizedBox(height: 50),
          const Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AddEditRecipeTitle(
                  title: "Ingredients",
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                heightFactor: 0.5,
                child: BakingUpCircularAddButton(),
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
                return AddEditRecipeIngredient(
                  recipeIngredients: recipeIngredients,
                  index: index,
                );
              }),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BakingUpLongActionButton(title: 'Cancel', color: greyColor),
              const SizedBox(width: 8),
              BakingUpLongActionButton(title: 'Next', color: lightRedColor)
            ],
          )
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

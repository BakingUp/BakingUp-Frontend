// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_add_recipe_ingredient_button.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_recipe_ingredient_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_recipe_ingredient_detail.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';

class AddEditRecipeIngredientScreen extends StatefulWidget {
  const AddEditRecipeIngredientScreen({super.key});

  @override
  State<AddEditRecipeIngredientScreen> createState() =>
      _AddEditRecipeIngredientScreenState();
}

class _AddEditRecipeIngredientScreenState
    extends State<AddEditRecipeIngredientScreen> {
  List<RecipeIngredientDetail> recipeIngredientDetails = [
    RecipeIngredientDetail(
      imgUrl: 'https://i.imgur.com/RLsjqFm.png',
      name: 'All-purpose flour',
      stock: 2,
      quantity: 1.4,
      unit: 'kg',
      expirationStatus: ExpirationStatus.red,
    ),
    RecipeIngredientDetail(
      imgUrl:
          'https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg',
      name: 'Sugar',
      stock: 1,
      quantity: 1,
      unit: 'kg',
      expirationStatus: ExpirationStatus.green,
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
          "Ingredients",
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
      body: AddEditRecipeIngredientContainer(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
            child: const Row(
              children: [
                BakingUpSearchBar(hintText: 'Search ingredients'),
                SizedBox(width: 12),
                BakingUpFilterTwoButton(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: recipeIngredientDetails.length + 1,
              itemBuilder: (context, index) {
                if (index < recipeIngredientDetails.length) {
                  return AddEditRecipeIngredientDetail(
                    recipeIngredientDetails: recipeIngredientDetails,
                    index: index,
                  );
                } else {
                  return const AddEditAddRecipeIngredientButton();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeIngredientDetail {
  final String imgUrl;
  final String name;
  final int stock;
  final double quantity;
  final String unit;
  final ExpirationStatus expirationStatus;

  RecipeIngredientDetail({
    required this.imgUrl,
    required this.name,
    required this.stock,
    required this.quantity,
    required this.unit,
    required this.expirationStatus,
  });
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/baking_up_tab_button.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredients_item.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_recipes_item.dart';
import 'package:flutter/material.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  int tabIndex = 1;
  final int _currentDrawerIndex = 3;

  List<IngredientItem> ingredientList = [
    IngredientItem(
      imgUrl: 'https://i.imgur.com/RLsjqFm.png',
      name: 'All-purpose flour',
      stock: 2,
      quantity: 1.4,
      unit: 'kg',
      expirationStatus: ExpirationStatus.red,
    ),
    IngredientItem(
      imgUrl:
          'https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg',
      name: 'Sugar',
      stock: 1,
      quantity: 1,
      unit: 'kg',
      expirationStatus: ExpirationStatus.green,
    ),
  ];

  List<RecipeItem> recipeList = [
    RecipeItem(
        imgUrl:
            'https://divascancook.com/wp-content/uploads/2023/12/butter-cookies.jpg',
        name: 'Butter Cookies',
        totalTime: '1 hr 40 mins',
        servingAmount: 36,
        score: 10,
        star: 4),
    RecipeItem(
        imgUrl: 'https://bakerjo.co.uk/wp-content/uploads/2022/08/IMG_3525.jpg',
        name: 'Carrot Cake',
        totalTime: '2 hr 40 mins',
        servingAmount: 1,
        score: 9,
        star: 4),
    RecipeItem(
        imgUrl:
            'https://www.inspiredtaste.net/wp-content/uploads/2024/01/Brownies-Recipe-Video.jpg',
        name: 'Chocolate Brownie',
        totalTime: '1 hr 50 mins',
        servingAmount: 24,
        score: 3,
        star: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
          title: const Text(
            "Warehouse",
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
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
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: BakingUpCircularAddButton(),
            )
          ],
        ),
        drawer: BakingUpDrawer(
          currentDrawerIndex: _currentDrawerIndex,
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                  child: Row(
                    children: [
                      BakingUpTabButton(
                          text: "Recipes",
                          isSelected: tabIndex == 1,
                          onClick: () {
                            setState(() {
                              tabIndex = 1;
                            });
                          }),
                      const SizedBox(
                        width: 40,
                      ),
                      BakingUpTabButton(
                          text: "Ingredients",
                          isSelected: tabIndex == 2,
                          onClick: () {
                            setState(() {
                              tabIndex = 2;
                            });
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      if (tabIndex == 1)
                        const BakingUpSearchBar(
                          hintText: 'Search Recipe',
                        ),
                      if (tabIndex == 2)
                        const BakingUpSearchBar(
                          hintText: 'Search Ingredient',
                        ),
                      const SizedBox(width: 12),
                      const BakingUpFilterTwoButton()
                    ],
                  ),
                ),
                if (tabIndex == 1)
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return WarehouseRecipesItem(
                                recipeList: recipeList, index: index);
                          })),
                if (tabIndex == 2)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      itemCount: ingredientList.length,
                      itemBuilder: (context, index) {
                        return WarehouseIngredientsItem(
                            ingredientList: ingredientList, index: index);
                      },
                    ),
                  ),
              ],
            )));
  }
}

class RecipeItem {
  final String imgUrl;
  final String name;
  final String totalTime;
  final int servingAmount;
  final int score;
  final int star;

  RecipeItem(
      {required this.imgUrl,
      required this.name,
      required this.totalTime,
      required this.servingAmount,
      required this.score,
      required this.star});
}

class IngredientItem {
  final String imgUrl;
  final String name;
  final int stock;
  final double quantity;
  final String unit;
  final ExpirationStatus expirationStatus;

  IngredientItem({
    required this.imgUrl,
    required this.name,
    required this.stock,
    required this.quantity,
    required this.unit,
    required this.expirationStatus,
  });
}

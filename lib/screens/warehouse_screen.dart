import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/baking_up_tab_button.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredient/warehouse_ingredient_filter.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredient/warehouse_ingredient_list.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_recipe/warehouse_recipes_list.dart';
import 'package:flutter/material.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  int tabIndex = 1;
  final int _currentDrawerIndex = 3;
  bool isLoading = true;
  bool isError = true;
  List<RecipeItemData> recipes = [];
  List<IngredientItemData> ingredients = [];
  List<RecipeItemData> filteredRecipes = [];
  List<IngredientItemData> filteredIngredients = [];
  final TextEditingController _searchRecipeController = TextEditingController();
  final TextEditingController _searchIngredientController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRecipeList();
  }

  Future<void> _fetchRecipeList() async {
    setState(() {
      isLoading = true;
      isError = false;
      _searchRecipeController.clear();
    });

    try {
      final response = await NetworkService.instance
          .get('/api/recipe/getAllRecipes?user_id=1');

      final recipeListResponse = RecipeListResponse.fromJson(response);
      final data = recipeListResponse.data;
      setState(() {
        recipes = data.recipeList;
        filteredRecipes = recipes;
      });

      setState(() {});
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

  Future<void> _fetchIngredientList() async {
    setState(() {
      isLoading = true;
      isError = false;
      _searchIngredientController.clear();
    });

    try {
      final response = await NetworkService.instance
          .get('/api/ingredient/getAllIngredients?user_id=1');

      final ingredientListResponse = IngredietnListResponse.fromJson(response);
      final data = ingredientListResponse.data;
      setState(() {
        ingredients = data.ingredientList;
        filteredIngredients = ingredients;
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

  void _filterRecipes(String query) {
    setState(() {
      if (query == "") {
        filteredRecipes = recipes;
      } else {
        filteredRecipes = recipes
            .where((recipe) =>
                recipe.recipeName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _filterIngredients(String query) {
    setState(() {
      filteredIngredients = ingredients
          .where((ingredient) => ingredient.ingredientName
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

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
                              _fetchRecipeList();
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
                              _fetchIngredientList();
                            });
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                  child: Row(
                    children: [
                      if (tabIndex == 1)
                        BakingUpSearchBar(
                          hintText: 'Search Recipe',
                          controller: _searchRecipeController,
                          onChanged: _filterRecipes,
                        ),
                      if (tabIndex == 2)
                        BakingUpSearchBar(
                          hintText: 'Search Ingredient',
                          controller: _searchIngredientController,
                          onChanged: _filterIngredients,
                        ),
                      const SizedBox(width: 12),
                      const BakingUpFilterTwoButton()
                    ],
                  ),
                ),
                if (tabIndex == 1)
                  WarehouseRecipeList(
                      recipeList: filteredRecipes, isLoading: isLoading),
                if (tabIndex == 2)
                  WarehouseIngredientList(
                      ingredientList: filteredIngredients,
                      isLoading: isLoading),
              ],
            )));
  }
}

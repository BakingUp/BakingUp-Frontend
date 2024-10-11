import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/baking_up_tab_button.dart';
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
  final List<String> recipeFilterList = [
    'Recipe Name',
    'Total Time',
    'Serving Amount',
    'Rating',
    'Selling Amount'
  ];
  final List<String> ingredientFilterList = [
    'Stock Name',
    'Quantity',
    'Expiration Date'
  ];
  String selectedRecipeFiltering = "Recipe Name";
  String selectedRecipeSorting = "Ascending Order";
  String selectedIngredientFiltering = "Stock Name";
  String selectedIngredientSorting = "Ascending Order";
  FocusNode recipeSearchFocusNode = FocusNode();
  FocusNode ingredientSearchFocusNode = FocusNode();
  bool noResult = false;
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
      noResult = false;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/recipe/getAllRecipes?user_id=1');

      final recipeListResponse = RecipeListResponse.fromJson(response);
      final data = recipeListResponse.data;
      setState(() {
        recipes = data.recipeList;
        filteredRecipes = recipes;
        selectedRecipeFiltering = "Recipe Name";
        selectedRecipeSorting = "Ascending Order";
        if (recipeListResponse.status == 200 && recipes.isEmpty) {
          noResult = true;
        }
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

  Future<void> _fetchIngredientList() async {
    setState(() {
      isLoading = true;
      isError = false;
      _searchIngredientController.clear();
      noResult = false;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/ingredient/getAllIngredients?user_id=1');

      final ingredientListResponse = IngredientListResponse.fromJson(response);
      final data = ingredientListResponse.data;
      setState(() {
        ingredients = data.ingredientList;
        filteredIngredients = ingredients;
        selectedIngredientFiltering = "Stock Name";
        selectedIngredientSorting = "Ascending Order";
        if (ingredientListResponse.status == 200 && ingredients.isEmpty) {
          noResult = true;
        }
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

  void _searchRecipes(String query) {
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
    if (selectedRecipeSorting == "Descending Order") {
      filteredRecipes.sort((a, b) => b.recipeName.compareTo(a.recipeName));
    }
  }

  void _filterRecipe(
      String selectingRecipeFiltering, String selectingRecipeSorting) {
    setState(() {
      selectedRecipeFiltering = selectingRecipeFiltering;
      selectedRecipeSorting = selectingRecipeSorting;
    });
    if (selectedRecipeSorting == "Ascending Order") {
      switch (selectingRecipeFiltering) {
        case "Recipe Name":
          filteredRecipes.sort((a, b) => a.recipeName.compareTo(b.recipeName));
          break;
        case "Total Time":
          filteredRecipes.sort((a, b) => a.totalTime.compareTo(b.totalTime));
          break;
        case "Serving Amount":
          filteredRecipes.sort((a, b) => a.servings.compareTo(b.servings));
          break;
        case "Rating":
          filteredRecipes.sort((a, b) => a.stars.compareTo(b.stars));
          break;
        case "Selling Amount":
          filteredRecipes.sort((a, b) => a.numOfOrder.compareTo(b.numOfOrder));
          break;
        default:
          filteredRecipes.sort((a, b) => a.recipeName.compareTo(b.recipeName));
      }
    } else {
      switch (selectingRecipeFiltering) {
        case "Recipe Name":
          filteredRecipes.sort((a, b) => b.recipeName.compareTo(a.recipeName));
          break;
        case "Total Time":
          filteredRecipes.sort((a, b) => b.totalTime.compareTo(a.totalTime));
          break;
        case "Serving Amount":
          filteredRecipes.sort((a, b) => b.servings.compareTo(a.servings));
          break;
        case "Rating":
          filteredRecipes.sort((a, b) => b.stars.compareTo(a.stars));
          break;
        case "Selling Amount":
          filteredRecipes.sort((a, b) => b.numOfOrder.compareTo(a.numOfOrder));
          break;
        default:
          filteredRecipes.sort((a, b) => b.recipeName.compareTo(a.recipeName));
      }
    }
  }

  void _searchIngredients(String query) {
    setState(() {
      filteredIngredients = ingredients
          .where((ingredient) => ingredient.ingredientName
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
    if (selectedIngredientSorting == "Descending Order") {
      filteredIngredients
          .sort((a, b) => b.ingredientName.compareTo(a.ingredientName));
    }
  }

  void _filterIngredient(
      String selectingIngredientFiltering, String selectingIngredientSorting) {
    setState(() {
      selectedIngredientFiltering = selectingIngredientFiltering;
      selectedIngredientSorting = selectingIngredientSorting;
    });
    if (selectedIngredientSorting == "Ascending Order") {
      switch (selectedIngredientFiltering) {
        case "Stock Name":
          filteredIngredients
              .sort((a, b) => a.ingredientName.compareTo(b.ingredientName));
          break;
        case "Quantity":
          filteredIngredients.sort((a, b) => a.quantity.compareTo(b.quantity));
          break;
        case "Expiration Date":
          filteredIngredients.sort((a, b) =>
              convertExpirationDate(a.expirationStatus)
                  .compareTo(convertExpirationDate(b.expirationStatus)));
          break;
        default:
          filteredIngredients
              .sort((a, b) => a.ingredientName.compareTo(b.ingredientName));
      }
    } else {
      switch (selectedIngredientFiltering) {
        case "Stock Name":
          filteredIngredients
              .sort((a, b) => b.ingredientName.compareTo(a.ingredientName));
          break;
        case "Quantity":
          filteredIngredients.sort((a, b) => b.quantity.compareTo(a.quantity));
          break;
        case "Expiration Date":
          filteredIngredients.sort((a, b) =>
              convertExpirationDate(b.expirationStatus)
                  .compareTo(convertExpirationDate(a.expirationStatus)));
          break;
        default:
          filteredIngredients
              .sort((a, b) => b.ingredientName.compareTo(a.ingredientName));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ingredientSearchFocusNode.unfocus();
          recipeSearchFocusNode.unfocus();
        },
        child: Scaffold(
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: BakingUpCircularAddButton(
                  onPressed: () {
                    if (tabIndex == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddEditRecipeScreen()));
                    } else if (tabIndex == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEditIngredientScreen(),
                        ),
                      ).then((_) {
                        _fetchIngredientList();
                      });
                    }
                  },
                ),
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
                                ingredientSearchFocusNode.unfocus();
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
                                recipeSearchFocusNode.unfocus();
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
                            onChanged: _searchRecipes,
                            focusNode: recipeSearchFocusNode,
                          ),
                        if (tabIndex == 2)
                          BakingUpSearchBar(
                            hintText: 'Search Ingredient',
                            controller: _searchIngredientController,
                            onChanged: _searchIngredients,
                            focusNode: ingredientSearchFocusNode,
                          ),
                        const SizedBox(width: 12),
                        GestureDetector(
                            onTap: () {
                              ingredientSearchFocusNode.unfocus();
                              recipeSearchFocusNode.unfocus();
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: backgroundColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return tabIndex == 1
                                      ? BakingUpFilterModalBottom(
                                          optionsOne: recipeFilterList,
                                          optionOneName: "Filter by",
                                          defaultFilteringValue:
                                              selectedRecipeFiltering,
                                          defaultSortingValue:
                                              selectedRecipeSorting,
                                          filterFunction: _filterRecipe,
                                        )
                                      : BakingUpFilterModalBottom(
                                          optionsOne: ingredientFilterList,
                                          optionOneName: "Filter by",
                                          defaultFilteringValue:
                                              selectedIngredientFiltering,
                                          defaultSortingValue:
                                              selectedIngredientSorting,
                                          filterFunction: _filterIngredient,
                                        );
                                },
                              );
                            },
                            child: const BakingUpFilterTwoButton())
                      ],
                    ),
                  ),
                  if (tabIndex == 1 && noResult)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: const BakingUpNoResult(
                        message: "You currently have no recipes",
                      ),
                    )
                  else if (tabIndex == 1 &&
                      !noResult &&
                      recipes.isNotEmpty &&
                      filteredRecipes.isEmpty)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: const BakingUpNoResult(
                        message: "No results found",
                      ),
                    )
                  else if (tabIndex == 1 && !noResult)
                    WarehouseRecipeList(
                      recipeList: filteredRecipes,
                      isLoading: isLoading,
                    ),
                  if (tabIndex == 2 && noResult)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: const BakingUpNoResult(
                        message: "You currently have no ingredients",
                      ),
                    )
                  else if (tabIndex == 2 &&
                      !noResult &&
                      ingredients.isNotEmpty &&
                      filteredIngredients.isEmpty)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: const BakingUpNoResult(
                        message: "No results found",
                      ),
                    )
                  else if (tabIndex == 2 && !noResult)
                    WarehouseIngredientList(
                      ingredientList: filteredIngredients,
                      isLoading: isLoading,
                    )
                ],
              )),
        ));
  }
}

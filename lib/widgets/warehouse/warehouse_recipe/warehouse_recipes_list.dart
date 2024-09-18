import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_recipe/warehouse_recipe_item_loading.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_recipe/warehouse_recipes_item.dart';
import 'package:flutter/material.dart';

class WarehouseRecipeList extends StatelessWidget {
  final List<RecipeItemData> recipeList;
  final bool isLoading;
  const WarehouseRecipeList(
      {super.key, required this.recipeList, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const WarehouseRecipeItemLoading();
            },
          ))
        : Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            itemCount: recipeList.length,
            itemBuilder: (context, index) {
              return WarehouseRecipesItem(
                  recipeList: recipeList, index: index, isLoading: isLoading);
            },
          ));
  }
}

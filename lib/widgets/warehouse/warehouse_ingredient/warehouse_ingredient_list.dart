import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredient/warehouse_ingredient_item_loading.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredient/warehouse_ingredients_item.dart';
import 'package:flutter/material.dart';

class WarehouseIngredientList extends StatelessWidget {
  final List<IngredientItemData> ingredientList;
  final bool isLoading;
  const WarehouseIngredientList(
      {super.key, required this.ingredientList, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const WarehouseIngredientsItemLoading();
            },
          ))
        : Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            itemCount: ingredientList.length,
            itemBuilder: (context, index) {
              return WarehouseIngredientsItem(
                  ingredientList: ingredientList,
                  index: index,
                  isLoading: isLoading);
            },
          ));
  }
}

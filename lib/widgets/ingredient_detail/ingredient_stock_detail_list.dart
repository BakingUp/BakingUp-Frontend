import 'package:bakingup_frontend/screens/ingredient_detail_screen.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_stock_detail.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_stock_detail_loading.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailList extends StatelessWidget {
  final List<IngredientStock> ingredientStocks;
  final bool isLoading;

  const IngredientStockDetailList({
    super.key,
    required this.ingredientStocks,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const IngredientStockDetailLoading();
              },
            ),
          )
        : Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: ingredientStocks.length,
              itemBuilder: (context, index) {
                return IngredientStockDetail(
                  ingredientStocks: ingredientStocks,
                  index: index,
                  isLoading: isLoading,
                );
              },
            ),
          );
  }
}

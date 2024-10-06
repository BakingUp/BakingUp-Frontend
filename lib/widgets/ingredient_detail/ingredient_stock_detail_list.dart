import 'package:bakingup_frontend/models/ingredient_detail.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
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
        : ingredientStocks.isEmpty
            ? const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BakingUpNoResult(
                        message: "This ingredient currently has no stocks."),
                    SizedBox(
                      height: 60,
                    ),
                  ],
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

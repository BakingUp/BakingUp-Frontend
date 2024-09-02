import 'package:bakingup_frontend/screens/ingredient_stock_detail_screen.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_detail.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_detail_loading.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailNoteList extends StatelessWidget {
  final List<IngredientStockDetailNote> ingredientStockDetailNotes;
  final bool isLoading;
  const IngredientStockDetailNoteList({
    super.key,
    required this.ingredientStockDetailNotes,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const IngredientStockDetailNoteDetailLoading();
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: ingredientStockDetailNotes.length,
            itemBuilder: (context, index) {
              return IngredientStockDetailNoteDetail(
                ingredientStockDetailNotes: ingredientStockDetailNotes,
                index: index,
              );
            },
          );
  }
}

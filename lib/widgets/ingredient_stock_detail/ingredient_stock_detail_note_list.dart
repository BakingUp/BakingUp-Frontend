import 'package:bakingup_frontend/models/ingredient_stock_detail.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_detail.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_detail_loading.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailNoteList extends StatefulWidget {
  final List<IngredientStockDetailNote> ingredientStockDetailNotes;
  final bool isLoading;
  final Function(int) onDelete;
  const IngredientStockDetailNoteList({
    super.key,
    required this.ingredientStockDetailNotes,
    required this.isLoading,
    required this.onDelete,
  });

  @override
  State<IngredientStockDetailNoteList> createState() =>
      _IngredientStockDetailNoteListState();
}

class _IngredientStockDetailNoteListState
    extends State<IngredientStockDetailNoteList> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
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
            itemCount: widget.ingredientStockDetailNotes.length,
            itemBuilder: (context, index) {
              return IngredientStockDetailNoteDetail(
                  ingredientStockDetailNote:
                      widget.ingredientStockDetailNotes[index],
                  onDelete: () {
                    widget.onDelete(index);
                  });
            },
          );
  }
}

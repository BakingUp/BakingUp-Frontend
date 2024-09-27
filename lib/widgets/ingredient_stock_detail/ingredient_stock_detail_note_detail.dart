import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/ingredient_stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_delete_button.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailNoteDetail extends StatefulWidget {
  final IngredientStockDetailNote ingredientStockDetailNote;
  final VoidCallback onDelete;

  const IngredientStockDetailNoteDetail({
    super.key,
    required this.ingredientStockDetailNote,
    required this.onDelete,
  });

  @override
  State<IngredientStockDetailNoteDetail> createState() =>
      _IngredientStockDetailNoteDetailState();
}

class _IngredientStockDetailNoteDetailState
    extends State<IngredientStockDetailNoteDetail> {
  Future<void> _deleteIngredientBatchNote() async {
    showDialog(
      context: context,
      barrierColor: const Color(0xC7D9D9D9),
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );
    final ingredientNoteId = widget.ingredientStockDetailNote.ingredientNoteId;
    await NetworkService.instance.delete(
      '/api/ingredient/deleteIngredientBatchNote?ingredient_note_id=$ingredientNoteId',
    );
    widget.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 16),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: beigeColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  widget.ingredientStockDetailNote.ingredientNote,
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IngredientStockDetailDeleteButton(
                        dialogParams: BakingUpDialogParams(
                          title: "Confirm Delete?",
                          imgUrl: "assets/icons/delete_warning.png",
                          content:
                              "This will permanently delete the note. Are you sure you want to proceed?",
                          grayButtonTitle: "Cancel",
                          secondButtonTitle: "Delete",
                          secondButtonColor: lightRedColor,
                          grayButtonOnClick: () {
                            Navigator.of(context).pop();
                          },
                          secondButtonOnClick: () {
                            Navigator.of(context).pop();
                            _deleteIngredientBatchNote().then(
                              (_) {
                                Navigator.of(context).pop();
                              },
                            ).catchError((onError) {
                              Navigator.of(context).pop();
                              Navigator.of(context).overlay!.insert(
                                OverlayEntry(
                                  builder: (BuildContext context) {
                                    return const BakingUpErrorTopNotification(
                                      message:
                                          "Sorry, we couldn’t delete the note due to a system error. Please try again later.",
                                    );
                                  },
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.ingredientStockDetailNote.noteCreatedAt,
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

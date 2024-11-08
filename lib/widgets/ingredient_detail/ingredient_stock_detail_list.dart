import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/ingredient_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_stock_detail.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_stock_detail_loading.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailList extends StatefulWidget {
  final List<IngredientStock> ingredientStocks;
  final String ingredientId;
  final bool isLoading;
  final VoidCallback fetchIngredientList;

  const IngredientStockDetailList({
    super.key,
    required this.ingredientStocks,
    required this.ingredientId,
    required this.isLoading,
    required this.fetchIngredientList,
  });

  @override
  State<IngredientStockDetailList> createState() =>
      _IngredientStockDetailListState();
}

class _IngredientStockDetailListState extends State<IngredientStockDetailList> {
  Future<void> _deleteIngredientStock(String ingredientStockId) async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    await NetworkService.instance.delete(
        '/api/ingredient/deleteIngredientStock?ingredient_stock_id=$ingredientStockId');
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const IngredientStockDetailLoading();
              },
            ),
          )
        : widget.ingredientStocks.isEmpty
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
                  itemCount: widget.ingredientStocks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(widget.ingredientStocks[index].stockId),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: redColor,
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BakingUpDialog(
                                title: "Confirm Delete?",
                                imgUrl: "assets/icons/delete_warning.png",
                                content:
                                    "Are you sure you want to delete this ingredient stock?",
                                grayButtonTitle: "Cancel",
                                secondButtonTitle: "Delete",
                                secondButtonColor: lightRedColor,
                                grayButtonOnClick: () {
                                  Navigator.pop(context);
                                },
                                secondButtonOnClick: () {
                                  Navigator.of(context).pop();
                                  _deleteIngredientStock(widget
                                          .ingredientStocks[index].stockId)
                                      .then((_) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      widget.ingredientStocks.removeAt(index);
                                    });
                                  }).catchError(
                                    (error) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).overlay!.insert(
                                        OverlayEntry(
                                          builder: (BuildContext context) {
                                            return const BakingUpErrorTopNotification(
                                              message:
                                                  "Sorry, we couldn’t delete the ingredient due to a system error. Please try again later.",
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            });
                      },
                      child: IngredientStockDetail(
                        ingredientStocks: widget.ingredientStocks,
                        ingredientId: widget.ingredientId,
                        index: index,
                        isLoading: widget.isLoading,
                        fetchIngredientList: widget.fetchIngredientList,
                      ),
                    );
                  },
                ),
              );
  }
}

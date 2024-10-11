import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredient/warehouse_ingredient_item_loading.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_ingredient/warehouse_ingredients_item.dart';
import 'package:flutter/material.dart';

class WarehouseIngredientList extends StatefulWidget {
  final List<IngredientItemData> ingredientList;
  final bool isLoading;
  final Future<void> Function() fetchIngredientList;
  const WarehouseIngredientList({
    super.key,
    required this.ingredientList,
    required this.isLoading,
    required this.fetchIngredientList,
  });

  @override
  State<WarehouseIngredientList> createState() =>
      _WarehouseIngredientListState();
}

class _WarehouseIngredientListState extends State<WarehouseIngredientList> {
  Future<void> _deleteIngredient(String ingredientId) async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    await NetworkService.instance
        .delete('/api/ingredient/deleteIngredient?ingredient_id=$ingredientId');
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const WarehouseIngredientsItemLoading();
                  },
                )))
        : Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  itemCount: widget.ingredientList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(widget.ingredientList[index].ingredientId),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                    "Are you sure you want to delete this ingredient?",
                                grayButtonTitle: "Cancel",
                                secondButtonTitle: "Delete",
                                secondButtonColor: lightRedColor,
                                grayButtonOnClick: () {
                                  Navigator.pop(context);
                                },
                                secondButtonOnClick: () {
                                  Navigator.of(context).pop();
                                  _deleteIngredient(widget
                                          .ingredientList[index].ingredientId)
                                      .then((_) {
                                    Navigator.of(context).pop();
                                  }).catchError((error) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .overlay!
                                        .insert(OverlayEntry(
                                      builder: (BuildContext context) {
                                        return const BakingUpErrorTopNotification(
                                          message:
                                              "Sorry, we couldn’t delete the ingredient due to a system error. Please try again later.",
                                        );
                                      },
                                    ));
                                  });
                                },
                              );
                            });
                      },
                      onDismissed: (direction) {
                        setState(() {
                          widget.ingredientList.removeAt(index);
                        });
                      },
                      child: WarehouseIngredientsItem(
                        ingredientList: widget.ingredientList,
                        index: index,
                        isLoading: widget.isLoading,
                        fetchIngredientList: widget.fetchIngredientList,
                      ),
                    );
                  },
                )));
  }
}

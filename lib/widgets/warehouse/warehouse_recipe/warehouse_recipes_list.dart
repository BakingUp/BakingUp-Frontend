import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_recipe/warehouse_recipe_item_loading.dart';
import 'package:bakingup_frontend/widgets/warehouse/warehouse_recipe/warehouse_recipes_item.dart';
import 'package:flutter/material.dart';

class WarehouseRecipeList extends StatefulWidget {
  final List<RecipeItemData> recipeList;
  final bool isLoading;
  final Future<void> Function() fetchRecipeList;
  const WarehouseRecipeList({
    super.key,
    required this.recipeList,
    required this.isLoading,
    required this.fetchRecipeList,
  });

  @override
  State<WarehouseRecipeList> createState() => WarehouseRecipeListState();
}

class WarehouseRecipeListState extends State<WarehouseRecipeList> {
  Future<void> _deleteRecipe(String recipeId) async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    await NetworkService.instance
        .delete('/api/recipe/deleteRecipe?recipe_id=$recipeId');
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
                    return const WarehouseRecipeItemLoading();
                  },
                )))
        : Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  itemCount: widget.recipeList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(widget.recipeList[index].recipeID),
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
                                    "Are you sure you want to delete this recipe?",
                                grayButtonTitle: "Cancel",
                                secondButtonTitle: "Delete",
                                secondButtonColor: lightRedColor,
                                grayButtonOnClick: () {
                                  Navigator.pop(context);
                                },
                                secondButtonOnClick: () {
                                  Navigator.of(context).pop();
                                  _deleteRecipe(
                                          widget.recipeList[index].recipeID)
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
                                              "Sorry, we couldn’t delete the recipe due to a system error. Please try again later.",
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
                          widget.recipeList.removeAt(index);
                        });
                      },
                      child: WarehouseRecipesItem(
                        recipeList: widget.recipeList,
                        index: index,
                        isLoading: widget.isLoading,
                        fetchRecipeList: widget.fetchRecipeList,
                      ),
                    );
                  },
                )));
  }
}

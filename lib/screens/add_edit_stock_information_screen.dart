// Importing libraries
import 'dart:developer';
import 'package:bakingup_frontend/models/add_edit_stock_detail_controller.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_sell_by_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_note_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_ingredient.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_quantity_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/models/stock_recipe_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_ingredient_loading.dart';
import 'package:shimmer/shimmer.dart';

class AddEditStockInformationScreen extends StatefulWidget {
  final String? recipeId;
  const AddEditStockInformationScreen({
    super.key,
    this.recipeId,
  });

  @override
  State<AddEditStockInformationScreen> createState() =>
      _AddEditStockInformationScreenState();
}

class _AddEditStockInformationScreenState
    extends State<AddEditStockInformationScreen> {
  final int _currentDrawerIndex = 4;
  String stockName = '';
  bool isLoading = false;
  bool isError = false;
  List<StockRecipeIngredientData> stockIngredients = [];
  String totalTime = '';
  String servings = '';
  final AddEditStockDetailController controller =
      AddEditStockDetailController();
  FocusNode sellByDateFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();

  Future<void> _fetchRecipeDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/stock/getStockRecipeDetail?recipe_id=${widget.recipeId}',
      );
      log('response: $response');
      final stockDetailResponse = StockRecipeDetailResponse.fromJson(response);
      log('stockDetailResponse: $stockDetailResponse');
      final data = stockDetailResponse.data;
      setState(() {
        stockName = data.recipeName;
        stockIngredients = data.ingredients;
        totalTime = data.totalTime;
        servings = data.servings.toString();
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRecipeDetails();
  }

  double calculateIngredientQuantity(
      int inputQuantity, double ingredientQuantity) {
    if (inputQuantity == -1) {
      return ingredientQuantity;
    }

    return ingredientQuantity * inputQuantity / double.parse(servings);
  }

  bool isQuantityMoreThanStock(
      int inputQuantity, double stockQuantity, double ingredientQuantity) {
    return calculateIngredientQuantity(inputQuantity, ingredientQuantity) >
        stockQuantity;
  }

  bool isAtLeastOneQuantityMoreThanStock() {
    for (int i = 0; i < stockIngredients.length; i++) {
      if (isQuantityMoreThanStock(
          controller.quantityController.text != ""
              ? int.parse(controller.quantityController.text)
              : -1,
          stockIngredients[i].stockQuantity,
          stockIngredients[i].ingredientQuantity)) {
        return true;
      }
    }
    return false;
  }

  List<Map<String, dynamic>> generateIngredientList() {
    List<Map<String, dynamic>> ingredientList = [];
    for (var ingredient in stockIngredients) {
      ingredientList.add({
        'ingredient_id': ingredient.ingredientId,
        'quantity': calculateIngredientQuantity(
                controller.quantityController.text != ""
                    ? int.parse(controller.quantityController.text)
                    : -1,
                ingredient.ingredientQuantity)
            .toString(),
      });
    }
    return ingredientList;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sellByDateFocusNode.unfocus();
        quantityFocusNode.unfocus();
        noteFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
          title: const Text(
            "Bakery Stock",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        drawer: BakingUpDrawer(
          currentDrawerIndex: _currentDrawerIndex,
        ),
        body: AddEditStockInformationContainer(
          children: [
            const AddEditStockInformationTitle(
                title: "Bakery Stock Information"),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Bakery Recipe',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 16),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: 120,
                          height: 45,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              stockName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  'Sell-By Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '*',
                  style: TextStyle(
                    color: redColor,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                AddEditStockInformationSellByDateField(
                  controller: controller.sellByDateController,
                  focusNode: sellByDateFocusNode,
                  onChanged: () {
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: beigeColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: greyColor,
                              highlightColor: whiteColor,
                              child: Container(
                                width: 80,
                                height: 23,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                ),
                              ),
                            )
                          : Text(
                              stockName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Total Time: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              isLoading
                                  ? Shimmer.fromColors(
                                      baseColor: greyColor,
                                      highlightColor: whiteColor,
                                      child: Container(
                                        width: 120,
                                        height: 20,
                                        padding:
                                            const EdgeInsets.only(bottom: 3),
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      totalTime,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Baseline servings: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              isLoading
                                  ? Shimmer.fromColors(
                                      baseColor: greyColor,
                                      highlightColor: whiteColor,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        padding: const EdgeInsets.only(top: 3),
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      servings,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                'Required Quantity',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: redColor,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 8),
                              AddEditStockInformationQuantityField(
                                controller: controller.quantityController,
                                focusNode: quantityFocusNode,
                                onChanged: () {
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          const Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isLoading
                                  ? const AddEditStockInformationIngredientLoading()
                                  : Container(),
                              ...stockIngredients.asMap().entries.map((entry) {
                                int index = entry.key;
                                return AddEditStockInformationIngredient(
                                  stockIngredient: stockIngredients[index],
                                  quantity: controller
                                              .quantityController.text !=
                                          ""
                                      ? int.parse(
                                          controller.quantityController.text)
                                      : -1,
                                  servings: int.parse(servings),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isAtLeastOneQuantityMoreThanStock()
                ? Column(
                    children: [
                      const SizedBox(height: 30.0),
                      Text(
                        "*Red text indicates insufficient ingredients for this recipe. Please add ingredients before proceeding.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: redColor,
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 30.0),
            const AddEditStockInformationTitle(title: "Note:"),
            const SizedBox(height: 16),
            AddEditStockInformationNoteTextField(
              controller: controller.noteController,
              focusNode: noteFocusNode,
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                  title: 'Confirm',
                  color: isAtLeastOneQuantityMoreThanStock() ||
                          controller.quantityController.text == "" ||
                          controller.sellByDateController.text == ""
                      ? greyColor
                      : lightGreenColor,
                  isDisabled: isAtLeastOneQuantityMoreThanStock() ||
                      controller.quantityController.text == "" ||
                      controller.sellByDateController.text == "",
                  dialogParams: BakingUpDialogParams(
                    title: 'Confirm Production?',
                    imgUrl: 'assets/icons/confirm_production.png',
                    content:
                        'You\'re about to start a new batch of ${controller.quantityController.text} $stockName. Your ingredient will automatically be adjusted.',
                    grayButtonTitle: 'Cancel',
                    grayButtonOnClick: () => Navigator.of(context).pop(),
                    secondButtonTitle: 'Confirm',
                    secondButtonColor: lightGreenColor,
                    secondButtonOnClick: () async {
                      try {
                        final data = {
                          "recipe_id": widget.recipeId,
                          "sell_by_date": controller.sellByDateController.text,
                          "quantity": controller.quantityController.text,
                          "note": controller.noteController.text,
                          "ingredients": generateIngredientList(),
                        };
                        await NetworkService.instance
                            .post(
                          "/api/stock/addStockDetail",
                          data: data,
                        )
                            .then(
                          (value) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).overlay!.insert(
                          OverlayEntry(
                            builder: (BuildContext context) {
                              return const BakingUpErrorTopNotification(
                                message:
                                    "Sorry, we couldn’t add the stock batch due to a system error. Please try again later.",
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Temporary class to simulate the data
class StockIngredient {
  final String ingredientUrl;
  final String ingredientName;
  final String unit;
  final double totalQuantity;
  final double usedQuantity;

  StockIngredient({
    required this.ingredientUrl,
    required this.ingredientName,
    required this.unit,
    required this.totalQuantity,
    required this.usedQuantity,
  });
}

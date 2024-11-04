// Importing libraries
import 'dart:developer';

import 'package:bakingup_frontend/models/stock_recipe_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock_information/add_edit_stock_information_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const AddEditStockInformationTitle(title: "Bakery Stock Information"),
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
              Container(
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
              const AddEditStockInformationSellByDateField(),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Cooking Time',
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
              const SizedBox(width: 16),
              const AddEditStockInformationTextField(label: "Hr", width: 46),
              const SizedBox(width: 16),
              const Text(
                'hrs.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16),
              const AddEditStockInformationTextField(label: "Min", width: 46),
              const SizedBox(width: 16),
              const Text(
                'mins.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
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
                    Text(
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
                        const Text(
                          "Total Time: 1 hr 40 mins",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          "Baseline servings: 36",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
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
                            const AddEditStockInformationQuantityField(),
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
                            ...stockIngredients.asMap().entries.map((entry) {
                              int index = entry.key;
                              return AddEditStockInformationIngredient(
                                  stockIngredient: stockIngredients[index]);
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
          const SizedBox(height: 30.0),
          const AddEditStockInformationTitle(title: "Note:"),
          const SizedBox(height: 16),
          const AddEditStockInformationNoteTextField(),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BakingUpLongActionButton(
                title: 'Confirm',
                color: lightGreenColor,
                dialogParams: BakingUpDialogParams(
                  title: 'Confirm Production?',
                  imgUrl: 'assets/icons/confirm_production.png',
                  content:
                      'You\'re about to start a new batch of 72 ${stockName.toLowerCase()}.',
                  grayButtonTitle: 'Cancel',
                  secondButtonTitle: 'Confirm',
                  secondButtonColor: lightGreenColor,
                ),
              )
            ],
          )
        ],
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

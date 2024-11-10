import 'dart:developer';

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/recipe_detail.dart';
import 'package:bakingup_frontend/models/recipe_detail_controller.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_hidden_costs.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_labor_costs.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_price_detail.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_profit_margin.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_raw_materials.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_text_field.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecipeDetailCostSection extends StatelessWidget {
  final String recipeId;
  final List<RecipeIngredient> recipeIngredients;
  final bool isLoading;
  final RecipeDetailController controller;
  final String totalTime;
  final int servings;
  final FocusNode hiddenCostFocusNode;
  final FocusNode laborCostFocusNode;
  final FocusNode profitMarginFocusNode;
  final VoidCallback onTextChanged;

  const RecipeDetailCostSection({
    super.key,
    required this.recipeId,
    required this.recipeIngredients,
    required this.isLoading,
    required this.controller,
    required this.totalTime,
    required this.servings,
    required this.hiddenCostFocusNode,
    required this.laborCostFocusNode,
    required this.profitMarginFocusNode,
    required this.onTextChanged,
  });

  double calculateTotalIngredientCost(
      List<RecipeIngredient> recipeIngredients) {
    double totalCost = 0.0;
    for (var ingredient in recipeIngredients) {
      if (ingredient.ingredientPrice == -1) {
        return -1;
      }
      totalCost += ingredient.ingredientPrice;
    }
    return double.parse(totalCost.toStringAsFixed(2));
  }

  double calculateTotalCost() {
    if (calculateTotalIngredientCost(recipeIngredients) == -1) {
      return -1;
    }
    double totalCost = 0.0;
    totalCost += calculateTotalIngredientCost(recipeIngredients);
    totalCost += calculateTotalIngredientCost(recipeIngredients) *
        double.parse(controller.hiddenCostController.text.isNotEmpty
            ? controller.hiddenCostController.text
            : '0') /
        100;
    totalCost += convertTotalTimeToMins(totalTime) *
        double.parse(controller.laborCostController.text.isNotEmpty
            ? controller.laborCostController.text
            : '0') /
        60;
    return totalCost;
  }

  double calculateTotalPrice() {
    if (calculateTotalCost() == -1) {
      return -1;
    }
    double totalPrice = 0.0;
    totalPrice += calculateTotalCost();
    totalPrice += calculateTotalCost() *
        double.parse(controller.profitMarginController.text.isNotEmpty
            ? controller.profitMarginController.text
            : '0') /
        100;
    return totalPrice;
  }

  int convertTotalTimeToMins(String totalTime) {
    final regex = RegExp(r'(\d+)\s*hrs?\s*(\d+)?\s*mins?');
    final match = regex.firstMatch(totalTime);

    int hours = 0;
    int minutes = 0;

    if (match != null) {
      if (match.group(1) != null) {
        hours = int.parse(match.group(1)!);
      }
      if (match.group(2) != null) {
        minutes = int.parse(match.group(2)!);
      }
    } else {
      final hourRegex = RegExp(r'(\d+)\s*hrs?');
      final minuteRegex = RegExp(r'(\d+)\s*mins?');

      final hourMatch = hourRegex.firstMatch(totalTime);
      final minuteMatch = minuteRegex.firstMatch(totalTime);

      if (hourMatch != null) {
        hours = int.parse(hourMatch.group(1)!);
      }
      if (minuteMatch != null) {
        minutes = int.parse(minuteMatch.group(1)!);
      }
    }

    return hours * 60 + minutes;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0, 0, 10.0),
              child: RecipeDetailTitle(title: "Cost"),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raw material costs',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
            RecipeDetailRawMaterials(
              recipeIngredients: recipeIngredients,
              isLoading: isLoading,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total: ${calculateTotalIngredientCost(recipeIngredients) == -1 ? "-" : NumberFormat('#,##0.00').format(calculateTotalIngredientCost(recipeIngredients)).replaceAll(removeTrailingZeros, '')} ฿",
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 30)
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hidden costs',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 36),
                    RecipeDetailTextField(
                      width: 50,
                      controller: controller.hiddenCostController,
                      min: 0,
                      max: 999,
                      focusNode: hiddenCostFocusNode,
                      onTextChanged: () async {
                        onTextChanged();
                        try {
                          await NetworkService.instance.put(
                            '/api/recipe/updateHiddenCost',
                            data: {
                              'recipe_id': recipeId,
                              'hidden_cost':
                                  controller.hiddenCostController.text
                            },
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '%',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Hidden costs',
                      style: TextStyle(
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
                    RecipeDetailHiddenCosts(
                      isLoading: isLoading,
                      hiddenCost:
                          calculateTotalIngredientCost(recipeIngredients) == -1
                              ? -1
                              : calculateTotalIngredientCost(
                                      recipeIngredients) *
                                  double.parse(controller
                                          .hiddenCostController.text.isNotEmpty
                                      ? controller.hiddenCostController.text
                                      : '0') /
                                  100,
                    ),
                    const SizedBox(width: 30),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Labor costs',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 36),
                    RecipeDetailTextField(
                      width: 75,
                      controller: controller.laborCostController,
                      min: 0,
                      max: 9999,
                      focusNode: laborCostFocusNode,
                      onTextChanged: () async {
                        onTextChanged();
                        try {
                          await NetworkService.instance.put(
                            '/api/recipe/updateLaborCost',
                            data: {
                              'recipe_id': recipeId,
                              'labor_cost': controller.laborCostController.text
                            },
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Baht per hour',
                      style: TextStyle(
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
                    RecipeDetailLaborCosts(
                      isLoading: isLoading,
                      laborCost: convertTotalTimeToMins(totalTime) *
                          double.parse(
                              controller.laborCostController.text.isNotEmpty
                                  ? controller.laborCostController.text
                                  : '0') /
                          60,
                    ),
                    const SizedBox(width: 30),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            RecipeDetailPriceDetail(
              color: beigeColor,
              header: "Total cost:",
              price: calculateTotalCost(),
              isLoading: isLoading,
            ),
            RecipeDetailPriceDetail(
              color: darkBeigeColor,
              header: "Cost per Serving:",
              price: calculateTotalIngredientCost(recipeIngredients) == -1
                  ? -1
                  : calculateTotalCost() / servings,
              isLoading: isLoading,
            ),
            const SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(15.0, 0, 0, 10.0),
              child: RecipeDetailTitle(title: "Price"),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profit margin',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 36),
                    RecipeDetailTextField(
                      width: 50,
                      controller: controller.profitMarginController,
                      min: 0,
                      max: 999,
                      focusNode: profitMarginFocusNode,
                      onTextChanged: () async {
                        onTextChanged();
                        try {
                          await NetworkService.instance.put(
                            '/api/recipe/updateProfitMargin',
                            data: {
                              'recipe_id': recipeId,
                              'profit_margin':
                                  controller.profitMarginController.text
                            },
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '%',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Profit margin',
                      style: TextStyle(
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
                    RecipeDetailProfitMargin(
                      isLoading: isLoading,
                      profitMargin:
                          calculateTotalIngredientCost(recipeIngredients) == -1
                              ? -1
                              : calculateTotalCost() *
                                  double.parse(controller.profitMarginController
                                          .text.isNotEmpty
                                      ? controller.profitMarginController.text
                                      : '0') /
                                  100,
                    ),
                    const SizedBox(width: 30),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            RecipeDetailPriceDetail(
              color: beigeColor,
              header: "Price:",
              price: calculateTotalPrice(),
              isLoading: isLoading,
            ),
            RecipeDetailPriceDetail(
              color: darkBeigeColor,
              header: "Price per Serving:",
              price: calculateTotalIngredientCost(recipeIngredients) == -1
                  ? -1
                  : calculateTotalPrice() / servings,
              isLoading: isLoading,
            ),
            const SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }
}

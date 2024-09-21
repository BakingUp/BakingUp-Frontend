import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/recipe_detail.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_hidden_costs.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_labor_costs.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_price_detail.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_profit_margin.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_raw_materials.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_text_field.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_title.dart';
import 'package:flutter/material.dart';

class RecipeDetailCostSection extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final bool isLoading;

  const RecipeDetailCostSection({
    super.key,
    required this.recipeIngredients,
    required this.isLoading,
  });

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
                const Row(
                  children: [
                    SizedBox(width: 36),
                    RecipeDetailTextField(width: 50),
                    SizedBox(width: 10),
                    Text(
                      '%',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 20),
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
                Row(
                  children: [
                    RecipeDetailHiddenCosts(
                      isLoading: isLoading,
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
                const Row(
                  children: [
                    SizedBox(width: 36),
                    RecipeDetailTextField(width: 75),
                    SizedBox(width: 20),
                    Text(
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
                    RecipeDetailLaborCosts(isLoading: isLoading),
                    const SizedBox(width: 30),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            RecipeDetailPriceDetail(
              color: beigeColor,
              header: "Total cost:",
              price: 390.8,
              isLoading: isLoading,
            ),
            RecipeDetailPriceDetail(
              color: darkBeigeColor,
              header: "Cost per Serving:",
              price: 10.86,
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
                const Row(
                  children: [
                    SizedBox(width: 36),
                    RecipeDetailTextField(width: 50),
                    SizedBox(width: 10),
                    Text(
                      '%',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 20),
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
                Row(
                  children: [
                    RecipeDetailProfitMargin(
                      isLoading: isLoading,
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
              price: 508.4,
              isLoading: isLoading,
            ),
            RecipeDetailPriceDetail(
              color: darkBeigeColor,
              header: "Price per Serving:",
              price: 14.11,
              isLoading: isLoading,
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}

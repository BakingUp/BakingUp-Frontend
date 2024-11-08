// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/widgets/baking_up_circular_back_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_back_button_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_scale_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_tab_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_ingredients_section.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instructions_section.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_edit_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_cost_section.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_edit_button_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_recipe_name.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_recipe_score.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_servings.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_total_time.dart';
import 'package:bakingup_frontend/widgets/baking_up_detail_image.dart';
import 'package:bakingup_frontend/models/recipe_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/models/recipe_detail_controller.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:intl/intl.dart';
import 'package:bakingup_frontend/constants/colors.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String? recipeId;
  const RecipeDetailScreen({super.key, this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  String recipeId = '';
  List<String> recipeUrl = [];
  String recipeName = '';
  int servings = 0;
  String totalTime = '';
  int star = 0;
  int score = 0;
  int tabIndex = 1;
  List<String> instructionUrls = [];
  String instructionSteps = "";
  List<RecipeIngredient> recipeIngredients = [];
  bool isLoading = false;
  bool isError = false;
  FocusNode hiddenCostFocusNode = FocusNode();
  FocusNode laborCostFocusNode = FocusNode();
  FocusNode profitMarginFocusNode = FocusNode();
  FocusNode scaleFocusNode = FocusNode();
  final RecipeDetailController _controller = RecipeDetailController();
  String scaledServings = "";

  @override
  void initState() {
    super.initState();
    _fetchRecipeDetails();
  }

  Future<void> _fetchRecipeDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/recipe/getRecipeDetail?recipe_id=${widget.recipeId}',
      );
      final recipeDetailResponse = RecipeDetailResponse.fromJson(response);
      final data = recipeDetailResponse.data;

      final newRecipeIngredients = data.recipeIngredients!.map((ingredient) {
        if (scaledServings == "") {
          return RecipeIngredient(
            ingredientName: ingredient.ingredientName,
            ingredientUrl: ingredient.ingredientUrl,
            ingredientQuantity: ingredient.ingredientQuantity,
            ingredientPrice: ingredient.ingredientPrice,
          );
        }
        final quantityParts = ingredient.ingredientQuantity.split(' ');
        final quantityValue = int.parse(quantityParts[0]);
        final unit = quantityParts[1];

        final scale = int.parse(scaledServings);
        final scaledQuantity = (quantityValue / data.servings) * scale;

        final newQuantity =
            '${NumberFormat('#,##0.00').format(scaledQuantity).replaceAll(removeTrailingZeros, '')} $unit';

        final newPrice =
            ingredient.ingredientPrice / quantityValue * scaledQuantity;

        return RecipeIngredient(
          ingredientName: ingredient.ingredientName,
          ingredientUrl: ingredient.ingredientUrl,
          ingredientQuantity: newQuantity,
          ingredientPrice: newPrice,
        );
      }).toList();

      setState(() {
        recipeId = widget.recipeId ?? '';
        recipeName = data.recipeName;
        recipeUrl = data.recipeUrl ?? [];
        totalTime = data.totalTime;
        servings = data.servings;
        star = data.stars;
        score = data.numOfOrder;
        recipeIngredients = newRecipeIngredients;
        instructionUrls = data.instructionUrl ?? [];
        instructionSteps = data.instructionSteps;
        _controller.hiddenCostController.text =
            data.hiddenCost.toString().replaceAll(removeTrailingZeros, '');
        _controller.laborCostController.text =
            data.laborCost.toString().replaceAll(removeTrailingZeros, '');
        _controller.profitMarginController.text =
            data.profitMargin.toString().replaceAll(removeTrailingZeros, '');
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hiddenCostFocusNode.unfocus();
        laborCostFocusNode.unfocus();
        profitMarginFocusNode.unfocus();
        scaleFocusNode.unfocus();
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            BakingUpDetailImage(
              imageUrl: recipeUrl,
              isScaled: scaledServings != "",
              isLoading: isLoading,
            ),
            const RecipeDetailEditButtonContainer(
              children: [
                BakingUpCircularEditButton(),
              ],
            ),
            const RecipeDetailBackButtonContainer(
              children: [
                BakingUpCircularBackButton(),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.5) + 125,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.width / 1.5) -
                    125,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RecipeDetailTabButton(
                              text: "Ingredients",
                              isSelected: tabIndex == 1,
                              onClick: () {
                                setState(() {
                                  tabIndex = 1;
                                });
                              },
                            ),
                            RecipeDetailTabButton(
                              text: "Instructions",
                              isSelected: tabIndex == 2,
                              onClick: () {
                                setState(() {
                                  tabIndex = 2;
                                });
                              },
                            ),
                            RecipeDetailTabButton(
                              text: "Cost & Price",
                              isSelected: tabIndex == 3,
                              onClick: () {
                                setState(() {
                                  tabIndex = 3;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (tabIndex == 1) ...[
                      if (recipeIngredients.isEmpty && !isLoading) ...[
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BakingUpNoResult(
                                  message:
                                      "This recipe currently has no ingredients."),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        RecipeDetailIngredientsSection(
                          recipeIngredients: recipeIngredients,
                          isLoading: isLoading,
                        ),
                      ]
                    ] else if (tabIndex == 2) ...[
                      if (instructionUrls.isEmpty &&
                          instructionSteps.isEmpty &&
                          !isLoading) ...[
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BakingUpNoResult(
                                  message:
                                      "This recipe currently has no instructions."),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        RecipeDetailInstructionsSection(
                          instructionUrls: instructionUrls,
                          instructionSteps: instructionSteps,
                          isLoading: isLoading,
                        ),
                      ],
                    ] else if (tabIndex == 3) ...[
                      if (recipeIngredients.isEmpty && !isLoading) ...[
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BakingUpNoResult(
                                  message:
                                      "This recipe currently has no ingredients."),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        RecipeDetailCostSection(
                          recipeId: recipeId,
                          recipeIngredients: recipeIngredients,
                          isLoading: isLoading,
                          controller: _controller,
                          totalTime: totalTime,
                          servings: scaledServings != ""
                              ? int.parse(scaledServings)
                              : servings,
                          hiddenCostFocusNode: hiddenCostFocusNode,
                          laborCostFocusNode: laborCostFocusNode,
                          profitMarginFocusNode: profitMarginFocusNode,
                          onTextChanged: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ]
                  ],
                ),
              ),
            ),
            scaledServings != ""
                ? Positioned(
                    top: MediaQuery.of(context).size.width / 1.5 - 35,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 5.0, 20.0),
                      decoration: BoxDecoration(
                        color: lightPinkColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Scaled Recipe",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    scaledServings = "";
                                    _fetchRecipeDetails();
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 20.0, // Adjust the size as needed
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            RecipeDetailContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          RecipeDetailRecipeName(
                            recipeName: recipeName,
                            isLoading: isLoading,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RecipeDetailRecipeScore(
                          score: score,
                          star: star,
                          isLoading: isLoading,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RecipeDetailTotalTime(
                            totalTime: totalTime,
                            isLoading: isLoading,
                            servings: servings,
                            isScaled: scaledServings != "",
                          ),
                          RecipeDetailServings(
                            servings: scaledServings != ""
                                ? int.parse(scaledServings)
                                : servings,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                      RecipeDetailScaleButton(
                        servings: servings,
                        focusNode: scaleFocusNode,
                        onScale: (p0) {
                          if (scaledServings != "" && int.parse(scaledServings) == servings) {
                            setState(() {
                              scaledServings = "";
                            });
                          } else {
                            setState(() {
                              scaledServings = p0;
                            });
                          }
                          _fetchRecipeDetails();
                        },
                        onDismissed: () {
                          scaleFocusNode.unfocus();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

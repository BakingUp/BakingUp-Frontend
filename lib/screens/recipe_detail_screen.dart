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

class RecipeDetailScreen extends StatefulWidget {
  final String? recipeId;
  const RecipeDetailScreen({super.key, this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  List<String> recipeUrl = [];
  String recipeName = '';
  int servings = 0;
  String totalTime = '';
  int star = 0;
  int score = 0;
  int tabIndex = 1;
  List<String> instructionUrls = [];
  List<String> instructionSteps = [];
  List<RecipeIngredient> recipeIngredients = [];
  bool isLoading = false;
  bool isError = false;

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
      setState(() {
        recipeName = data.recipeName;
        recipeUrl = data.recipeUrl ?? [];
        totalTime = data.totalTime;
        servings = data.servings;
        star = data.stars;
        score = data.numOfOrder;
        recipeIngredients = data.recipeIngredients ?? [];
        instructionUrls = data.instructionUrl ?? [];
        instructionSteps = data.instructionSteps ?? [];
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BakingUpDetailImage(
            imageUrl: recipeUrl,
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
                        recipeIngredients: recipeIngredients,
                        isLoading: isLoading,
                      ),
                    ],
                  ]
                ],
              ),
            ),
          ),
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
                        ),
                        RecipeDetailServings(
                          servings: servings,
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                    RecipeDetailScaleButton(servings: servings)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

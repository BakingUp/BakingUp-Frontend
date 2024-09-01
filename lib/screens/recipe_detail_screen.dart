// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/widgets/baking_up_circular_back_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_image_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_image.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_back_button_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_scale_button.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_screen.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_tab_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_title.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_ingredients_section.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instructions_section.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_edit_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_cost_section.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_edit_button_container.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_recipe_name.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_recipe_score.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_servings.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_total_time.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  String recipeUrl =
      'https://images.immediate.co.uk/production/volatile/sites/30/2021/09/butter-cookies-262c4fd.jpg';
  String recipeName = 'Butter Cookies';
  int servings = 36;
  String totalTime = '1 hr 40 mins';
  int star = 4;
  int score = 10;
  int tabIndex = 1;
  String instructionUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLTSzH9Swe-9qcnc00WSAUHJF8eksXx8EpkQ&s";
  List<String> instructions = [
    "Preheat oven to 350°F. Line a large baking sheet with parchment paper.",
    "In a large bowl using a hand mixer on medium speed, cream together the butter and sugar until light and fluffy.",
    "Add the egg yolks and vanilla. Mix until combined.",
    "In a separate bowl whisk together the flour and salt.",
    "Slowly add the flour mixture to the butter mixture. Mix on low until combined, scraping down the sides of the bowl as needed.",
    "Working 1 tablespoon at a time, add milk until the mixture is sticky, thick, and well combined. Set aside.",
    "This is a very thick batter, so you will need a heavy-duty piping bag, or you can use the double bag method. To do that you will need two piping bags, one fitted with a large star tip and one that has not been cut. Transfer the batter to the piping bag with no tip. Clip the tip of that bag and place it inside the second piping bag that is fitted with the star tip.",
    "Pipe the batter into a circular pattern onto the lined baking sheet, leaving about 1 inch in between each cookie.",
    "Bake 13-15 minutes, or until golden brown.",
    "Allow the cookies to cool on the baking sheet for 10 minutes before transferring to a cooling rack. Let the cookies cool completely before decorating.",
  ];
  List<RawMaterial> rawMaterials = [
    RawMaterial(name: "All-purpose flour", price: 37),
    RawMaterial(name: "Sugar", price: 38),
    RawMaterial(name: "Egg yolks", price: 39),
    RawMaterial(name: "Butter", price: 40),
  ];
  List<RecipeIngredient> recipeIngredients = [
    RecipeIngredient(
      imgUrl: "https://i.imgur.com/RLsjqFm.png",
      name: "All-purpose flour",
      quantity: "250 g",
    ),
    RecipeIngredient(
      imgUrl:
          "https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg",
      name: "Sugar",
      quantity: "150 g",
    ),
    RecipeIngredient(
      imgUrl:
          "https://www.eatthis.com/wp-content/uploads/sites/4/2022/06/Egg-Yolk-2.jpg?quality=82&strip=all",
      name: "Egg yolks",
      quantity: "120 g",
    ),
    RecipeIngredient(
      imgUrl:
          "https://www.bhg.com/thmb/-luCrhu9Eh1C2u-oZXseX5tKAbk=/3000x0/filters:no_upscale():strip_icc()/bhg-how-many-grams-are-in-one-stick-of-butter-03-2c71be43bb20474384f7483c3827f8e7.jpg",
      name: "Butter",
      quantity: "454 g",
    ),
  ];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String title;
    switch (tabIndex) {
      case 1:
        title = 'Ingredients';
        break;
      case 2:
        title = 'Instructions';
        break;
      case 3:
        title = 'Cost';
        break;
      default:
        title = 'Recipe Detail';
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          RecipeDetailImageContainer(
            child: RecipeDetailImage(
              recipeUrl: recipeUrl,
              isLoading: isLoading,
            ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 10.0),
                    child: tabIndex != 3
                        ? RecipeDetailTitle(title: title)
                        : Container(),
                  ),
                  if (tabIndex == 1)
                    RecipeDetailIngredientsSection(
                      recipeIngredients: recipeIngredients,
                      isLoading: isLoading,
                    ),
                  if (tabIndex == 2)
                    RecipeDetailInstructionsSection(
                      instructionUrl: instructionUrl,
                      instructions: instructions,
                      isLoading: isLoading,
                    ),
                  if (tabIndex == 3)
                    RecipeDetailCostSection(
                      rawMaterials: rawMaterials,
                      isLoading: isLoading,
                    ),
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

// Temporary class to simulate the data
class RawMaterial {
  final String name;
  final double price;

  RawMaterial({
    required this.name,
    required this.price,
  });
}

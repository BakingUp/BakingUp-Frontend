// Importing libraries
import 'package:bakingup_frontend/screens/add_edit_ingredient_screen.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_recipe_ingredient_detail_loading.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_add_recipe_ingredient_button.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_recipe_ingredient_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_recipe_ingredient/add_edit_recipe_ingredient_detail.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/services/network_service.dart';

class AddEditRecipeIngredientScreen extends StatefulWidget {
  const AddEditRecipeIngredientScreen({super.key});

  @override
  State<AddEditRecipeIngredientScreen> createState() =>
      _AddEditRecipeIngredientScreenState();
}

class _AddEditRecipeIngredientScreenState
    extends State<AddEditRecipeIngredientScreen> {
  bool isLoading = true;
  bool isError = false;
  List<IngredientItemData> recipeIngredientDetails = [];

  Future<void> _fetchIngredientList() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/ingredient/getAllIngredients?user_id=1');

      final ingredientListResponse = IngredientListResponse.fromJson(response);
      final data = ingredientListResponse.data;
      setState(() {
        recipeIngredientDetails = data.ingredientList;
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
    _fetchIngredientList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Ingredients",
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
      body: AddEditRecipeIngredientContainer(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
            child: const Row(
              children: [
                BakingUpSearchBar(hintText: 'Search ingredients'),
                SizedBox(width: 12),
                BakingUpFilterTwoButton(),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const AddEditRecipeIngredientDetailLoading();
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: recipeIngredientDetails.length + 1,
                    itemBuilder: (context, index) {
                      if (index < recipeIngredientDetails.length) {
                        return AddEditRecipeIngredientDetail(
                          recipeIngredientDetails: recipeIngredientDetails,
                          index: index,
                        );
                      } else {
                        return AddEditAddRecipeIngredientButton(onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddEditIngredientScreen(),
                            ),
                          ).then((_) {
                            _fetchIngredientList();
                          });
                        });
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

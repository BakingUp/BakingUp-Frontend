// Importing libraries
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_text_field_with_label.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/models/add_edit_stock_controller.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final int _currentDrawerIndex = 4;
  final AddEditStockController _controller = AddEditStockController();
  List<String> recipeList = [];
  List<RecipeItemData> recipeObject = [];
  String selectedBakeryRecipe = '';
  RecipeItemData? selectedBakeryRecipeObject;
  bool isLoading = true;
  bool isError = false;
  FocusNode lstFocusNode = FocusNode();
  FocusNode sellingPriceFocusNode = FocusNode();
  FocusNode expirationDateFocusNode = FocusNode();
  FocusNode stockLessThanFocusNode = FocusNode();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _fetchRecipeList() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final recipeResponse = await NetworkService.instance
          .get('/api/recipe/getAllRecipes?user_id=$userId');
      final recipeListResponse = RecipeListResponse.fromJson(recipeResponse);
      final recipeData = recipeListResponse.data;

      final stockResponse = await NetworkService.instance
          .get('/api/stock/getAllStocks?user_id=$userId');
      final stockListResponse = StockListResponse.fromJson(stockResponse);
      final stockData = stockListResponse.data;

      final stockIDs = stockData.stocks.map((stock) => stock.stockID).toSet();
      final filteredRecipeNames = recipeData.recipeList
          .where((recipe) => !stockIDs.contains(recipe.recipeID))
          .map((recipe) => recipe.recipeName)
          .toList();

      final filteredRecipeObjects = recipeData.recipeList
          .where((recipe) => !stockIDs.contains(recipe.recipeID))
          .toList();

      setState(() {
        recipeList = filteredRecipeNames;
        recipeObject = filteredRecipeObjects;
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
    _fetchRecipeList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        lstFocusNode.unfocus();
        sellingPriceFocusNode.unfocus();
        expirationDateFocusNode.unfocus();
        stockLessThanFocusNode.unfocus();
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
        body: AddEditStockContainer(
          children: [
            const AddEditStockTitle(title: "Adding Bakery stock"),
            const SizedBox(height: 16.0),
            Row(
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
                BakingUpDropdown(
                    options: recipeList,
                    topic: "Bakery Recipe",
                    selectedOption: selectedBakeryRecipe,
                    onApply: (String value) {
                      setState(() {
                        selectedBakeryRecipe = value;
                      });
                    },
                    onApplyIndex: (int value) {
                      setState(() {
                        selectedBakeryRecipeObject = recipeObject[value];
                      });
                    })
              ],
            ),
            selectedBakeryRecipe.isEmpty ||
                    (selectedBakeryRecipeObject != null &&
                        selectedBakeryRecipeObject!.recipeImg.isEmpty)
                ? Container()
                : const SizedBox(height: 16.0),
            selectedBakeryRecipe.isNotEmpty
                ? ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: double.infinity,
                      maxHeight: 200.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: selectedBakeryRecipeObject != null &&
                              selectedBakeryRecipeObject!.recipeImg.isNotEmpty
                          ? Image.network(
                              selectedBakeryRecipeObject!.recipeImg,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 30.0),
            Row(
              children: [
                const Text(
                  'LST',
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
                AddEditStockTextFieldWithLabel(
                  controller: _controller.lstController,
                  labelText: 'LST',
                  focusNode: lstFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Text(
                  'Low Stock Threshold (LST)',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Selling price',
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
                AddEditStockTextFieldWithLabel(
                  controller: _controller.sellingPriceController,
                  labelText: 'Selling price',
                  focusNode: sellingPriceFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  '฿',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const AddEditStockTitle(title: "Notification Setting"),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Notify me',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                AddEditStockTextField(
                  controller: _controller.expirationDateController,
                  focusNode: expirationDateFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
                ),
                const Text(
                  'days before sell-by date',
                  style: TextStyle(
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
                const Flexible(
                  child: Text(
                    'Notify me when stock is less than',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                AddEditStockTextField(
                  controller: _controller.stockLessThanController,
                  focusNode: stockLessThanFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
                ),
                const Text(
                  'unit',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                  title: 'Confirm',
                  color: _controller.lstController.text.isEmpty ||
                          _controller.sellingPriceController.text.isEmpty ||
                          _controller.sellingPriceController.text.isEmpty ||
                          _controller.stockLessThanController.text.isEmpty ||
                          selectedBakeryRecipe.isEmpty
                      ? greyColor
                      : lightGreenColor,
                  isDisabled: _controller.lstController.text.isEmpty ||
                      _controller.sellingPriceController.text.isEmpty ||
                      _controller.sellingPriceController.text.isEmpty ||
                      _controller.stockLessThanController.text.isEmpty ||
                      selectedBakeryRecipe.isEmpty,
                  dialogParams: BakingUpDialogParams(
                    title: 'Confirm Adding Stock?',
                    imgUrl: 'assets/icons/warning.png',
                    content:
                        'You\'re about to add new bakery stock to the stock page.',
                    grayButtonTitle: 'Cancel',
                    secondButtonTitle: 'Confirm',
                    secondButtonColor: lightGreenColor,
                    secondButtonOnClick: () async {
                      try {
                        final data = {
                          "stock_id":
                              selectedBakeryRecipeObject!.recipeID.toString(),
                          "selling_price":
                              _controller.sellingPriceController.text,
                          "lst": _controller.lstController.text,
                          "expiration_date":
                              _controller.expirationDateController.text,
                          "stock_less_than":
                              _controller.stockLessThanController.text,
                        };
                        await NetworkService.instance
                            .post(
                          "/api/stock/addStock",
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
                                    "Sorry, we couldn’t add the stock due to a system error. Please try again later.",
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

// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_ingredient_detail.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_container.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_stock_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';

class AddIngredientReceiptScreen extends StatefulWidget {
  const AddIngredientReceiptScreen({super.key});

  @override
  State<AddIngredientReceiptScreen> createState() =>
      _AddIngredientReceiptScreenState();
}

class _AddIngredientReceiptScreenState
    extends State<AddIngredientReceiptScreen> {
  final int _currentDrawerIndex = 4;
  final bool _isAllEdited = false;
  final List<IngredientDetail> ingredientDetail = [
    IngredientDetail(
      ingredientName: "Dragon Fruit",
      ingredientQuantity: "1",
      ingredientPrice: "50",
      isEdited: true,
    ),
    IngredientDetail(
      ingredientName: "Banana",
      ingredientQuantity: "3",
      ingredientPrice: "25",
      isEdited: false,
    ),
    IngredientDetail(
      ingredientName: "Whole Chicken",
      ingredientQuantity: "1",
      ingredientPrice: "150",
      isEdited: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Ingredient",
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
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Image.asset('assets/icons/camera.png'),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      body: AddIngredientReceiptContainer(
        children: [
          Expanded(
            child: Column(
              children: [
                const AddIngredientReceiptTitle(title: "Adding Ingredient"),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: ingredientDetail.length,
                    itemBuilder: (context, index) {
                      return AddIngredientReceiptIngredientDetail(
                        ingredientDetail: ingredientDetail[index],
                        index: index + 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                  title: 'Cancel',
                  color: greyColor,
                  isDisabled: false,
                ),
                const SizedBox(width: 8),
                _isAllEdited
                    ? BakingUpLongActionButton(
                        title: 'Confirm',
                        color: lightGreenColor,
                        isDisabled: false,
                        dialogParams: BakingUpDialogParams(
                          title: 'Confirm Adding Ingredient?',
                          imgUrl: 'assets/icons/warning.png',
                          content:
                              'You\'re about to add new ingredient data to the warehouse.',
                          grayButtonTitle: 'Cancel',
                          secondButtonTitle: 'Confirm',
                          secondButtonColor: lightGreenColor,
                        ),
                      )
                    : BakingUpLongActionButton(
                        title: 'Confirm',
                        color: lightGreenColor,
                        isDisabled: false,
                        dialogParams: BakingUpDialogParams(
                          title: 'Required Fields',
                          imgUrl: 'assets/icons/warning.png',
                          content:
                              'Please fill in all required fields before continuing.',
                          grayButtonTitle: 'Cancel',
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientDetail {
  final String ingredientName;
  final String ingredientQuantity;
  final String ingredientPrice;
  final bool isEdited;

  IngredientDetail({
    required this.ingredientName,
    required this.ingredientQuantity,
    required this.ingredientPrice,
    required this.isEdited,
  });
}

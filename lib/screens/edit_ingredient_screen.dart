// Importing libraries
import 'dart:developer';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_detail.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_controller.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EditIngredientScreen extends StatefulWidget {
  final String? ingredientId;
  const EditIngredientScreen({
    super.key,
    this.ingredientId,
  });

  @override
  State<EditIngredientScreen> createState() => _EditIngredientScreenState();
}

class _EditIngredientScreenState extends State<EditIngredientScreen> {
  final int _currentDrawerIndex = 4;
  String selectedUnit = '';
  final AddEditIngredientController _controller = AddEditIngredientController();
  bool isLoading = false;
  bool isError = false;
  FocusNode ingredientNameFocusNode = FocusNode();
  FocusNode ingredientLessThanFocusNode = FocusNode();
  FocusNode daysBeforeExpireFocusNode = FocusNode();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  String convertAbbreviation(String abbreviation) {
    switch (abbreviation) {
      case 'G':
        return 'Grams';
      case 'KG':
        return 'Kilograms';
      case 'L':
        return 'Litres';
      case 'ML':
        return 'Millilitres';
      default:
        return '';
    }
  }

  Future<void> _fetchAddEditIngredientStockDetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/ingredient/getAddEditIngredientDetail?ingredient_id=${widget.ingredientId}',
      );

      final addEditIngredientDetailResponse =
          AddEditIngredientDetailResponse.fromJson(response);
      final data = addEditIngredientDetailResponse.data;

      log(data.toString());

      setState(() {
        _controller.engNameController.text = data.ingredientEngName;
        _controller.thaiNameController.text = data.ingredientThaiName;
        selectedUnit = convertAbbreviation(data.unit);
        _controller.ingredientLessThanController.text = data.stockLessThan;
        _controller.daysBeforeExpireController.text = data.dayBeforeExpire;
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

  String convertUnit(String unit) {
    switch (unit) {
      case 'Grams':
        return 'G';
      case 'Kilograms':
        return 'KG';
      case 'Litres':
        return 'L';
      case 'Millilitres':
        return 'ML';
      default:
        return '';
    }
  }

  int getUnitLengthLimit(String unit) {
    switch (unit) {
      case 'Grams':
        return 5;
      case 'Kilograms':
        return 2;
      case 'Litres':
        return 2;
      case 'Millilitres':
        return 5;
      default:
        return 5;
    }
  }

  int getUnitMax(String unit) {
    switch (unit) {
      case 'Grams':
        return 99000;
      case 'Kilograms':
        return 99;
      case 'Litres':
        return 99;
      case 'Millilitres':
        return 99000;
      default:
        return 99000;
    }
  }

  bool getIsDisabled() {
    return (_controller.engNameController.text.isEmpty &&
            _controller.thaiNameController.text.isEmpty) ||
        selectedUnit.isEmpty ||
        _controller.ingredientLessThanController.text.isEmpty ||
        _controller.daysBeforeExpireController.text.isEmpty;
  }

  @override
  void initState() {
    super.initState();
    _fetchAddEditIngredientStockDetail();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ingredientNameFocusNode.unfocus();
        ingredientLessThanFocusNode.unfocus();
        daysBeforeExpireFocusNode.unfocus();
      },
      child: Scaffold(
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
        body: AddEditIngredientContainer(
          children: [
            const AddEditIngredientTitle(title: "Editing Ingredient"),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Ingredient Name',
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
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: greyColor,
                            highlightColor: whiteColor,
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          )
                        : AddEditIngredientNameTextField(
                            label: 'Ingredient Name',
                            controller: _controller.engNameController,
                            onTextChanged: () {
                              setState(() {});
                            },
                            focusNode: ingredientNameFocusNode,
                          ),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            const AddEditIngredientTitle(title: "Notification Setting"),
            const SizedBox(height: 16),
            Row(
              children: [
                const Flexible(
                  child: Text(
                    'Notify me when an ingredient falls below',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditIngredientTextField(
                        controller: _controller.ingredientLessThanController,
                        lengthLimit: getUnitLengthLimit(selectedUnit),
                        min: 1,
                        max: getUnitMax(selectedUnit),
                        onTextChanged: () {
                          setState(() {});
                        },
                        focusNode: ingredientLessThanFocusNode,
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditIngredientTextField(
                        controller: _controller.daysBeforeExpireController,
                        lengthLimit: 3,
                        min: 1,
                        max: 365,
                        onTextChanged: () {
                          setState(() {});
                        },
                        focusNode: daysBeforeExpireFocusNode,
                      ),
                const Text(
                  'days before expiration',
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
                  title: 'Save',
                  color: getIsDisabled() ? greyColor : lightGreenColor,
                  isDisabled: getIsDisabled(),
                  dialogParams: BakingUpDialogParams(
                    title: 'Confirm Ingredient Changes?',
                    imgUrl: 'assets/icons/warning.png',
                    content:
                        'You\'re about to save edited ingredient to the warehouse.',
                    grayButtonTitle: 'Cancel',
                    secondButtonTitle: 'Confirm',
                    secondButtonColor: lightGreenColor,
                    grayButtonOnClick: () {
                      Navigator.of(context).pop();
                    },
                    secondButtonOnClick: () async {
                      try {
                        final data = {
                          "day_before_expire":
                              _controller.daysBeforeExpireController.text,
                          "ingredient_eng_name":
                              _controller.engNameController.text,
                          "ingredient_thai_name":
                              _controller.thaiNameController.text,
                          "stock_less_than":
                              _controller.ingredientLessThanController.text,
                          "user_id": userId,
                          "ingredient_id": widget.ingredientId,
                        };
                        log(data.toString());
                        await NetworkService.instance
                            .put(
                          "/api/ingredient/editIngredient",
                          data: data,
                        )
                            .then(
                          (value) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        );
                      } catch (e) {
                        log(e.toString());
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).overlay!.insert(
                          OverlayEntry(
                            builder: (BuildContext context) {
                              return const BakingUpErrorTopNotification(
                                message:
                                    "Sorry, we couldn’t edit the ingredient due to a system error. Please try again later.",
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

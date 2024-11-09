// Importing libraries
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_ingredient_receipt_detail_controller.dart';
import 'package:bakingup_frontend/models/get_all_ingredient_ids_and_names.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_expiration_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_note_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddIngredientReceiptDetailScreen extends StatefulWidget {
  final String ingredientName;
  final String ingredientQuantity;
  final String ingredientPrice;
  final List<Ingredient>? ingredients;
    final Function(
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
  )? onAddIngredient;
  const AddIngredientReceiptDetailScreen({
    super.key,
    required this.ingredientName,
    required this.ingredientQuantity,
    required this.ingredientPrice,
    this.ingredients,
    this.onAddIngredient,
  });

  @override
  State<AddIngredientReceiptDetailScreen> createState() =>
      _AddIngredientReceiptDetailScreenState();
}

class _AddIngredientReceiptDetailScreenState
    extends State<AddIngredientReceiptDetailScreen> {
  final picker = ImagePicker();
  final int _currentDrawerIndex = 4;
  final List<File> _images = [];
  String selectedUnit = '';
  final AddIngredientReceiptDetailController _controller =
      AddIngredientReceiptDetailController();

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

  List<String> convertFilesToBase64(List<File> files) {
    return files.map((file) {
      final bytes = file.readAsBytesSync();
      return base64Encode(bytes);
    }).toList();
  }

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
          const AddEditIngredientTitle(title: "Ingredient Information"),
          BakingUpImagePicker(
            images: _images,
            onNewImage: (File image) {
              setState(() {
                _images.add(image);
              });
            },
            isOneImage: true,
            onDelete: (index) {
              setState(() {
                _images.removeAt(index);
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddEditIngredientNameTextField(
                    label: 'English',
                    controller: _controller.engNameController,
                    onTextChanged: () {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  AddEditIngredientNameTextField(
                    label: 'Thai',
                    controller: _controller.thaiNameController,
                    onTextChanged: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Brand',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16),
              AddEditIngredientStockTextField(
                label: "Brand",
                width: 150,
                controller: _controller.brandController,
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Quantity',
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
                  AddEditIngredientStockTextField(
                    label: 'Quantity',
                    width: MediaQuery.of(context).size.width - 300,
                    controller: _controller.quantityController,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Unit',
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
                    ],
                  ),
                  const SizedBox(width: 8),
                  BakingUpDropdown(
                    options: const [
                      'Grams',
                      'Kilograms',
                      'Litres',
                      'Millilitres',
                    ],
                    topic: 'Unit',
                    selectedOption: selectedUnit,
                    onApply: (String value) {
                      setState(() {
                        selectedUnit = value;
                        _controller.ingredientLessThanController.text = '';
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Price',
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
              AddEditIngredientStockTextField(
                label: "Price",
                width: 150,
                controller: _controller.priceController,
              )
            ],
          ),
          const SizedBox(height: 50),
          const AddEditIngredientStockTitle(title: "Additional Information"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Supplier',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16),
              AddEditIngredientStockTextField(
                label: "Supplier",
                width: 150,
                controller: _controller.supplierController,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    'Expiration Date',
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
                ],
              ),
              AddEditIngredientStockExpirationDateField(
                controller: _controller.expirationDateController,
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
              AddEditIngredientTextField(
                controller: _controller.ingredientLessThanController,
                lengthLimit: getUnitLengthLimit(selectedUnit),
                min: 1,
                max: getUnitMax(selectedUnit),
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
              AddEditIngredientTextField(
                controller: _controller.daysBeforeExpireController,
                lengthLimit: 3,
                min: 1,
                max: 365,
                onTextChanged: () {
                  setState(() {});
                },
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
          const SizedBox(height: 50),
          const AddEditIngredientStockTitle(title: "Note:"),
          const SizedBox(height: 16),
          AddEditIngredientStockNoteTextField(
            controller: _controller.noteController,
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
                  title: 'Confirm Adding Ingredient?',
                  imgUrl: 'assets/icons/warning.png',
                  content:
                      'Are you sure to add a new ingredient to the warehouse?',
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
                        "unit": convertUnit(selectedUnit),
                        "user_id": "1",
                        "img": convertFilesToBase64(_images),
                      };
                      log(data.toString());
                      await NetworkService.instance
                          .post(
                        "/api/ingredient/addIngredient",
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
                                  "Sorry, we couldn’t add the ingredient due to a system error. Please try again later.",
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
    );
  }
}

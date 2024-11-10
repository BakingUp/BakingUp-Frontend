// Importing libraries
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_ingredient_receipt_detail_controller.dart';
import 'package:bakingup_frontend/models/get_all_ingredient_ids_and_names.dart';
import 'package:bakingup_frontend/services/network_service.dart';
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
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddIngredientReceiptDetailScreen extends StatefulWidget {
  final String ingredientName;
  final String ingredientQuantity;
  final String ingredientPrice;
  final int? index;
  final List<Ingredient>? ingredientIdsAndNames;
  final Function(
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
    this.index,
    this.ingredientIdsAndNames,
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
  final ingredientIds = [];
  final ingredientNames = [];
  bool isIngredientNameInIngredientNames = false;
  final AddIngredientReceiptDetailController _controller =
      AddIngredientReceiptDetailController();
  String ingredientId = '';
  FocusNode ingredientNameFocusNode = FocusNode();
  FocusNode ingredientLessThanFocusNode = FocusNode();
  FocusNode daysBeforeExpireFocusNode = FocusNode();
  FocusNode brandFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode supplierFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();

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
  void initState() {
    super.initState();
    setState(() {
      _controller.engName = widget.ingredientName;
      _controller.quantity = widget.ingredientQuantity;
      _controller.price = widget.ingredientPrice;
      for (var element in widget.ingredientIdsAndNames!) {
        ingredientIds.add(element.ingredientId);
        ingredientNames.add(element.ingredientEngName.toLowerCase());
      }
      isIngredientNameInIngredientNames = ingredientNames
          .contains(_controller.engNameController.text.toLowerCase());
      if (isIngredientNameInIngredientNames) {
        final index = ingredientNames
            .indexOf(_controller.engNameController.text.toLowerCase());
        ingredientId = ingredientIds[index];
        selectedUnit =
            '${widget.ingredientIdsAndNames![index].unit.toLowerCase()}.';
      }
    });
  }

  bool shouldDisabled() {
    return (isIngredientNameInIngredientNames &&
                _controller.quantityController.text.isEmpty ||
            _controller.priceController.text.isEmpty ||
            _controller.expirationDateController.text.isEmpty) ||
        (!isIngredientNameInIngredientNames &&
                _controller.engNameController.text.isEmpty ||
            _controller.quantityController.text.isEmpty ||
            _controller.priceController.text.isEmpty ||
            _controller.expirationDateController.text.isEmpty &&
                _controller.daysBeforeExpireController.text.isEmpty &&
                _controller.ingredientLessThanController.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ingredientNameFocusNode.unfocus();
        ingredientLessThanFocusNode.unfocus();
        daysBeforeExpireFocusNode.unfocus();
        brandFocusNode.unfocus();
        quantityFocusNode.unfocus();
        priceFocusNode.unfocus();
        supplierFocusNode.unfocus();
        noteFocusNode.unfocus();
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
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AddEditIngredientNameTextField(
                      label: 'Ingredient Name',
                      controller: _controller.engNameController,
                      onTextChanged: () {
                        setState(() {
                          isIngredientNameInIngredientNames = ingredientNames
                              .contains(_controller.engNameController.text
                                  .toLowerCase());
                          log(ingredientNames
                              .contains(_controller.engNameController.text
                                  .toLowerCase())
                              .toString());
                          if (isIngredientNameInIngredientNames) {
                            final index = ingredientNames.indexOf(_controller
                                .engNameController.text
                                .toLowerCase());
                            ingredientId = ingredientIds[index];
                            selectedUnit =
                                '${widget.ingredientIdsAndNames![index].unit.toLowerCase()}.';
                          } else {
                            selectedUnit = '';
                          }
                        });
                      },
                      focusNode: ingredientNameFocusNode,
                    ),
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
                  focusNode: brandFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
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
                      focusNode: quantityFocusNode,
                      onTextChanged: () {
                        setState(() {});
                      },
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
                      disabled: isIngredientNameInIngredientNames,
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
                  focusNode: priceFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
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
                  focusNode: supplierFocusNode,
                  onTextChanged: () {
                    setState(() {});
                  },
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
                  onTextChanged: () {
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            !isIngredientNameInIngredientNames
                ? Column(
                    children: [
                      const AddEditIngredientTitle(
                          title: "Notification Setting"),
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
                            controller:
                                _controller.ingredientLessThanController,
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
                          AddEditIngredientTextField(
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
                      const SizedBox(height: 50),
                    ],
                  )
                : const SizedBox(),
            const AddEditIngredientStockTitle(title: "Note:"),
            const SizedBox(height: 16),
            AddEditIngredientStockNoteTextField(
              controller: _controller.noteController,
              focusNode: noteFocusNode,
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                  title: 'Save',
                  color: shouldDisabled() ? greyColor : lightGreenColor,
                  isDisabled: shouldDisabled(),
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
                      if (isIngredientNameInIngredientNames) {
                        try {
                          final data = {
                            "user_id": "1",
                            "ingredient_id": ingredientId,
                            "price": _controller.priceController.text,
                            "quantity": _controller.quantityController.text,
                            "expiration_date":
                                _controller.expirationDateController.text,
                            "supplier": _controller.supplierController.text,
                            "ingredient_brand":
                                _controller.brandController.text,
                            "img": _images.isNotEmpty
                                ? convertFilesToBase64(_images)[0]
                                : "",
                            "note": _controller.noteController.text,
                          };
                          await NetworkService.instance
                              .post(
                            "/api/ingredient/addIngredientStock",
                            data: data,
                          )
                              .then(
                            (value) {
                              widget.onAddIngredient!(
                                widget.index ?? 0,
                                _controller.engNameController.text,
                                _controller.quantityController.text,
                                _controller.priceController.text,
                              );
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
                      } else {
                        try {
                          final data = {
                            "brand": _controller.brandController.text,
                            "day_before_expire":
                                _controller.daysBeforeExpireController.text,
                            "expiration_date":
                                _controller.expirationDateController.text,
                            "img": _images.isNotEmpty
                                ? convertFilesToBase64(_images)[0]
                                : "",
                            "ingredient_eng_name":
                                _controller.engNameController.text,
                            "ingredient_thai_name":
                                _controller.thaiNameController.text,
                            "note": _controller.noteController.text,
                            "price": _controller.priceController.text,
                            "quantity": _controller.quantityController.text,
                            "stock_less_than":
                                _controller.ingredientLessThanController.text,
                            "supplier": _controller.supplierController.text,
                            "unit": convertUnit(selectedUnit),
                            "user_id": "1",
                          };
                          log(data.toString());
                          await NetworkService.instance
                              .post(
                            "/api/ingredient/addIngredientAndStock",
                            data: data,
                          )
                              .then((value) {
                            widget.onAddIngredient!(
                              widget.index ?? 0,
                              _controller.engNameController.text,
                              _controller.quantityController.text,
                              _controller.priceController.text,
                            );
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
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

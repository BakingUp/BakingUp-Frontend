// Importing libraries
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_unit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_delete_button.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_expiration_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_note_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_stock_controller.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_name_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';

class AddIngredientStockScreen extends StatefulWidget {
  final String? ingredientId;
  const AddIngredientStockScreen({super.key, this.ingredientId});

  @override
  State<AddIngredientStockScreen> createState() =>
      _AddIngredientStockScreenState();
}

class _AddIngredientStockScreenState extends State<AddIngredientStockScreen> {
  final bool _isEdit = false;
  final List<File> _images = [];
  String selectedUnit = '';
  bool isLoading = true;
  bool isError = false;
  String ingredientEngName = '';
  String ingredientThaiName = '';
  String unit = '';
  FocusNode brandFocusNode = FocusNode();
  FocusNode quantityFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode supplierFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final AddEditIngredientStockController _controller =
      AddEditIngredientStockController();

  List<String> convertFilesToBase64(List<File> files) {
    return files.map((file) {
      final bytes = file.readAsBytesSync();
      return base64Encode(bytes);
    }).toList();
  }

  Future<void> _fetchAddEditIngredientStockDetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/ingredient/getAddEditIngredientStockDetail?ingredient_id=${widget.ingredientId}',
      );

      final addEditIngredientDetailResponse =
          AddEditIngredientStockDetailResponse.fromJson(response);
      final data = addEditIngredientDetailResponse.data;

      setState(() {
        ingredientEngName = data.ingredientEngName;
        ingredientThaiName = data.ingredientThaiName;
        unit = data.unit;
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
    _fetchAddEditIngredientStockDetail();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
        body: AddEditIngredientStockContainer(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AddEditIngredientStockTitle(
                    title: "Ingredient Information"),
                AddEditIngredientStockDeleteButton(
                  dialogParams: BakingUpDialogParams(
                    title: "Confirm Delete?",
                    imgUrl: "assets/icons/delete_warning.png",
                    content: "Are you sure you want to delete this ingredient?",
                    grayButtonTitle: "Cancel",
                    secondButtonTitle: "Delete",
                    secondButtonColor: lightRedColor,
                  ),
                ),
              ],
            ),
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddEditIngredientStockNameTextField(
                      text: ingredientEngName,
                      isLoading: isLoading,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(width: 8),
                    AddEditIngredientStockUnit(
                      text: unit,
                      isLoading: isLoading,
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
            const SizedBox(height: 16),
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
                  controller: _controller.expirationController,
                  onTextChanged: () {
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
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
                  color: _controller.quantityController.text == '' ||
                          _controller.priceController.text == '' ||
                          _controller.expirationController.text == ''
                      ? greyColor
                      : lightGreenColor,
                  isDisabled: _controller.quantityController.text == '' ||
                      _controller.priceController.text == '' ||
                      _controller.expirationController.text == '',
                  dialogParams: BakingUpDialogParams(
                    title: _isEdit
                        ? 'Confirm Ingredient Changes?'
                        : 'Confirm Adding Ingredient?',
                    imgUrl: 'assets/icons/warning.png',
                    content: _isEdit
                        ? 'You\'re about to save edited ingredient to the warehouse.'
                        : 'Are you sure to add a new ingredient to the warehouse?',
                    grayButtonTitle: 'Cancel',
                    secondButtonTitle: 'Confirm',
                    secondButtonColor: lightGreenColor,
                    grayButtonOnClick: () {
                      Navigator.of(context).pop();
                    },
                    secondButtonOnClick: () async {
                      try {
                        final data = {
                          "user_id": userId,
                          "ingredient_id": widget.ingredientId,
                          "price": _controller.priceController.text,
                          "quantity": _controller.quantityController.text,
                          "expiration_date":
                              _controller.expirationController.text,
                          "supplier": _controller.supplierController.text,
                          "ingredient_brand": _controller.brandController.text,
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
                                    "Sorry, we couldn’t add the ingredient stock due to a system error. Please try again later.",
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

// Temporary class to simulate the data
class IngredientStockDetailNote {
  final String ingredientNote;
  final String noteCreatedAt;

  IngredientStockDetailNote({
    required this.ingredientNote,
    required this.noteCreatedAt,
  });
}

// Importing libraries
import 'dart:developer';
import 'package:bakingup_frontend/models/edit_ingredient_stock_detail.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_unit.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_expiration_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_note_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_stock_controller.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient_stock/add_edit_ingredient_stock_name_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:shimmer/shimmer.dart';

class EditIngredientStockScreen extends StatefulWidget {
  final String? ingredientId;
  final String? ingredientStockId;
  const EditIngredientStockScreen(
      {super.key, this.ingredientId, this.ingredientStockId});

  @override
  State<EditIngredientStockScreen> createState() =>
      _EditIngredientStockScreenState();
}

class _EditIngredientStockScreenState extends State<EditIngredientStockScreen> {
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

  final AddEditIngredientStockController _controller =
      AddEditIngredientStockController();

  Future<void> _fetchAddEditIngredientStockDetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      final responseOne = await NetworkService.instance.get(
        '/api/ingredient/getAddEditIngredientStockDetail?ingredient_id=${widget.ingredientId}',
      );

      final addEditIngredientDetailResponse =
          AddEditIngredientStockDetailResponse.fromJson(responseOne);
      final data = addEditIngredientDetailResponse.data;

      final responseTwo = await NetworkService.instance.get(
        '/api/ingredient/getEditIngredientStockDetail?ingredient_stock_id=${widget.ingredientStockId}',
      );
      final editIngredientStockDetailResponse =
          EditIngredientStockDetailResponse.fromJson(responseTwo);
      final editData = editIngredientStockDetailResponse.data;

      setState(() {
        ingredientEngName = data.ingredientEngName;
        ingredientThaiName = data.ingredientThaiName;
        unit = data.unit;
        _controller.brandController.text = editData.brand;
        _controller.quantityController.text = editData.quantity;
        _controller.priceController.text = editData.price;
        _controller.supplierController.text = editData.supplier;
        _controller.expirationController.text = editData.expirationDate;
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AddEditIngredientStockTitle(title: "Ingredient Information"),
              ],
            ),
            const SizedBox(height: 24),
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
                        const SizedBox(width: 16),
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditIngredientStockTextField(
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
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: greyColor,
                            highlightColor: whiteColor,
                            child: Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width - 300,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          )
                        : AddEditIngredientStockTextField(
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditIngredientStockTextField(
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditIngredientStockTextField(
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
                    : AddEditIngredientStockExpirationDateField(
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
                  color: lightGreenColor,
                  isDisabled: false,
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
                          "ingredient_stock_id": widget.ingredientStockId,
                          "price": _controller.priceController.text,
                          "quantity": _controller.quantityController.text,
                          "expiration_date":
                              _controller.expirationController.text,
                          "supplier": _controller.supplierController.text,
                          "ingredient_brand": _controller.brandController.text,
                          "note": _controller.noteController.text,
                        };
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          barrierColor: const Color(0xC7D9D9D9),
                          builder: (BuildContext context) {
                            return const BakingUpLoadingDialog();
                          },
                        );
                        await NetworkService.instance
                            .put(
                          "/api/ingredient/editIngredientStock",
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
                                    "Sorry, we couldn’t edit the ingredient stock due to a system error. Please try again later.",
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

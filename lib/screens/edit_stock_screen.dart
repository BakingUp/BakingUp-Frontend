// Importing libraries
import 'dart:developer';

import 'package:bakingup_frontend/models/edit_stock_detail.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
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
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/models/add_edit_stock_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shimmer/shimmer.dart';

class EditStockScreen extends StatefulWidget {
  final String? recipeId;
  const EditStockScreen({super.key, this.recipeId});

  @override
  State<EditStockScreen> createState() => _EditStockScreenState();
}

class _EditStockScreenState extends State<EditStockScreen> {
  final int _currentDrawerIndex = 4;
  final AddEditStockController _controller = AddEditStockController();
  String recipeName = '';
  String recipeUrl = '';
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

  Future<void> _fetchStockDetail() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final fetchStockResponse = await NetworkService.instance
          .get('/api/stock/getEditStockDetail?recipe_id=${widget.recipeId}');

      log(fetchStockResponse.toString());

      final getEditStockDetailResponse =
          EditStockDetailResponse.fromJson(fetchStockResponse);

      final data = getEditStockDetailResponse.data;

      setState(() {
        recipeName = data.recipeName;
        recipeUrl = data.recipeUrl;
        _controller.lstController.text = data.lst;
        _controller.sellingPriceController.text = data.sellingPrice;
        _controller.stockLessThanController.text = data.stockLessThan;
        _controller.expirationDateController.text = data.expirationDate;
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
    _fetchStockDetail();
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
            const AddEditStockTitle(title: "Editing Bakery stock"),
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 25,
                          width: 60,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          recipeName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
              ],
            ),
            recipeUrl.isEmpty ? Container() : const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: 200.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: recipeUrl.isNotEmpty
                    ? Image.network(
                        "${dotenv.env['API_BASE_URL']}/$recipeUrl",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox();
                        },
                      )
                    : const SizedBox(),
              ),
            ),
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditStockTextFieldWithLabel(
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
                isLoading
                    ? Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    : AddEditStockTextFieldWithLabel(
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
                    : AddEditStockTextField(
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
                    : AddEditStockTextField(
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
                          _controller.stockLessThanController.text.isEmpty ||
                          _controller.expirationDateController.text.isEmpty
                      ? greyColor
                      : lightGreenColor,
                  isDisabled: _controller.lstController.text.isEmpty ||
                      _controller.sellingPriceController.text.isEmpty ||
                      _controller.stockLessThanController.text.isEmpty ||
                      _controller.expirationDateController.text.isEmpty,
                  dialogParams: BakingUpDialogParams(
                    title: 'Confirm Stock Changes?',
                    imgUrl: 'assets/icons/warning.png',
                    content: 'You\'re about to save edited stock.',
                    grayButtonTitle: 'Cancel',
                    secondButtonTitle: 'Confirm',
                    secondButtonColor: lightGreenColor,
                    secondButtonOnClick: () async {
                      try {
                        final data = {
                          "recipe_id": widget.recipeId,
                          "selling_price":
                              _controller.sellingPriceController.text,
                          "lst": _controller.lstController.text,
                          "expiration_date":
                              _controller.expirationDateController.text,
                          "stock_less_than":
                              _controller.stockLessThanController.text,
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
                          "/api/stock/editStock",
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
                                    "Sorry, we couldn’t edit the stock due to a system error. Please try again later.",
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

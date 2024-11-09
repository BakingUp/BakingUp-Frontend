// Importing libraries
import 'dart:developer';
import 'dart:io';

import 'package:bakingup_frontend/models/get_all_ingredient_ids_and_names.dart'
    as ids;
import 'package:bakingup_frontend/models/get_ingredient_lists_from_receipt_response.dart'
    as receipt;
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_ingredient_detail_loading.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_ingredient_detail.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_container.dart';
import 'package:bakingup_frontend/widgets/add_ingredient_receipt/add_ingredient_receipt_stock_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AddIngredientReceiptScreen extends StatefulWidget {
  final File? file;
  const AddIngredientReceiptScreen({super.key, this.file});

  @override
  State<AddIngredientReceiptScreen> createState() =>
      _AddIngredientReceiptScreenState();
}

class _AddIngredientReceiptScreenState
    extends State<AddIngredientReceiptScreen> {
  final picker = ImagePicker();
  final int _currentDrawerIndex = 4;
  bool isError = false;
  bool isLoading = true;
  final List<IngredientDetail> ingredientDetail = [];
  File _receiptImage = File('');
  List<ids.Ingredient> ingredientIdsAndNames = [];

  Future<void> _fetchIngredients(File file) async {
    try {
      setState(() {
        isLoading = true;
        isError = false;
      });
      final bytes = file.readAsBytesSync();

      final formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(bytes,
            filename: widget.file!.path.split('/').last),
      });

      final response = await NetworkService.instance.post(
        '/api/ingredient/getIngredientListsFromReceipt',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      final getIngredientListsFromReceiptResponse =
          receipt.GetIngredientListsFromReceiptResponse.fromJson(response);

      final data = getIngredientListsFromReceiptResponse.data;

      final ingredientData = await NetworkService.instance
          .get('/api/ingredient/getAllIngredientIDsAndNames?user_id=1');

      final getAllIngredientIdsAndNamesResponse =
          ids.GetAllIngredientIdsAndNamesResponse.fromJson(ingredientData);

      setState(() {
        ingredientIdsAndNames =
            getAllIngredientIdsAndNamesResponse.data.ingredients;
        ingredientDetail.clear();
        ingredientDetail.addAll(data.ingredients
            .map(
              (e) => IngredientDetail(
                ingredientName: e.ingredientName,
                ingredientQuantity: e.quantity,
                ingredientPrice: e.price.replaceAll(removeTrailingZeros, ''),
                isEdited: false,
              ),
            )
            .toList());
      });

      log(data.toString());
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

  Future takePhoto() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    setState(() {
      _receiptImage = File(pickedFile!.path);
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      _receiptImage = File(pickedFile!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchIngredients(widget.file!);
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
              icon: Image.asset('assets/icons/scan_receipt.png'),
              onPressed: () async {
                final result = await BakingUpImagePickerBottomSheet.show(
                  context,
                  takePhoto,
                  getImageGallery,
                );
                if (result == true) {
                  _fetchIngredients(_receiptImage);
                }
              },
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
                const AddIngredientReceiptTitle(title: "Adding Ingredients"),
                const SizedBox(height: 16),
                Expanded(
                  child: isLoading
                      ? ListView.builder(
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return AddIngredientReceiptIngredientDetailLoading(
                              index: index + 1,
                            );
                          },
                        )
                      : ListView.builder(
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
                BakingUpLongActionButton(
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

class AddIngredient {
  final String ingredientEngName;
  final String ingredientThaiName;
  final String unit;
  final String stockLessThan;
  final String dayBeforeExpire;
  final String supplier;
  final String quantity;
  final String price;
  final String note;
  final String ingredientBrand;
  final String expirationDate;
  final File image;

  AddIngredient({
    required this.ingredientEngName,
    required this.ingredientThaiName,
    required this.unit,
    required this.stockLessThan,
    required this.dayBeforeExpire,
    required this.supplier,
    required this.quantity,
    required this.price,
    required this.note,
    required this.ingredientBrand,
    required this.expirationDate,
    required this.image,
  });
}

class AddIngredientDetail {
  final String ingredientId;
  final String supplier;
  final String quantity;
  final String price;
  final String note;
  final String ingredientBrand;
  final String expirationDate;
  final File image;

  AddIngredientDetail({
    required this.ingredientId,
    required this.supplier,
    required this.quantity,
    required this.price,
    required this.note,
    required this.ingredientBrand,
    required this.expirationDate,
    required this.image,
  });
}

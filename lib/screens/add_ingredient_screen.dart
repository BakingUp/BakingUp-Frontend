// Importing libraries
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/screens/add_ingredient_receipt_screen.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_name_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_ingredient/add_edit_ingredient_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker_bottom_sheet.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker.dart';
import 'package:bakingup_frontend/models/add_edit_ingredient_controller.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddIngredientScreen extends StatefulWidget {
  const AddIngredientScreen({super.key});

  @override
  State<AddIngredientScreen> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  final picker = ImagePicker();
  final int _currentDrawerIndex = 4;
  final List<File> _images = [];
  String selectedUnit = '';
  final AddEditIngredientController _controller = AddEditIngredientController();
  File _receiptImage = File('');
  final userId = FirebaseAuth.instance.currentUser!.uid;
  FocusNode ingredientNameFocusNode = FocusNode();
  FocusNode ingredientLessThanFocusNode = FocusNode();
  FocusNode daysBeforeExpireFocusNode = FocusNode();

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
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddIngredientReceiptScreen(file: _receiptImage),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
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
            const AddEditIngredientTitle(title: "Adding Ingredient"),
            BakingUpImagePicker(
              images: _images,
              onNewImage: (File image) {
                setState(() {
                  _images.add(image);
                });
              },
              isOneImage: false,
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
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AddEditIngredientNameTextField(
                      label: 'Ingredient Name',
                      controller: _controller.engNameController,
                      focusNode: ingredientNameFocusNode,
                      onTextChanged: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                          "user_id": userId,
                          "img": convertFilesToBase64(_images),
                        };
                        log(data.toString());
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          barrierColor: const Color(0xC7D9D9D9),
                          builder: (BuildContext context) {
                            return const BakingUpLoadingDialog();
                          },
                        );
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
      ),
    );
  }
}

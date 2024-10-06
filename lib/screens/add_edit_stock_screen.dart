// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_container.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_notification_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_title.dart';
import 'package:bakingup_frontend/widgets/add_edit_stock/add_edit_stock_lst_text_field.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';

class AddEditStockScreen extends StatefulWidget {
  const AddEditStockScreen({super.key});

  @override
  State<AddEditStockScreen> createState() => _AddEditStockScreenState();
}

class _AddEditStockScreenState extends State<AddEditStockScreen> {
  final int _currentDrawerIndex = 4;
  final bool _isEdit = false;
  final String recipeUrl =
      'https://images.immediate.co.uk/production/volatile/sites/30/2021/09/butter-cookies-262c4fd.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const BakingUpDropdown(text: 'select')
            ],
          ),
          const SizedBox(height: 16.0),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: 200.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                recipeUrl,
                fit: BoxFit.cover,
              ),
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
              const AddEditStockLstTextField(),
            ],
          ),
          const SizedBox(height: 8.0),
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
          const SizedBox(height: 50),
          const AddEditStockTitle(title: "Notification Setting"),
          const SizedBox(height: 16),
          const Row(
            children: [
              Text(
                'Notify me',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BakingUpDropdown(text: 'select'),
              ),
              Text(
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
          const SizedBox(height: 16),
          const Row(
            children: [
              Flexible(
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
              AddEditStockNotificationTextField(),
              Text(
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
              _isEdit
                  ? BakingUpLongActionButton(
                      title: 'Confirm',
                      color: lightGreenColor,
                    )
                  : BakingUpLongActionButton(
                      title: 'Confirm',
                      color: lightGreenColor,
                      dialogParams: BakingUpDialogParams(
                        title: 'Confirm Adding Stock?',
                        imgUrl: 'assets/icons/warning.png',
                        content:
                            'You\'re about to add new bakery stock to the stock page.',
                        grayButtonTitle: 'Cancel',
                        secondButtonTitle: 'Confirm',
                        secondButtonColor: lightGreenColor,
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}

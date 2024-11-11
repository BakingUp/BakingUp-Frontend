import 'dart:developer';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_edit_order_controller.dart';
import 'package:bakingup_frontend/models/stock_order_page.dart';
import 'package:bakingup_frontend/screens/auth/add_edit_order_stock_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_note_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_stock_main.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_time_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_tab_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditInstoreOrderScreen extends StatefulWidget {
  const AddEditInstoreOrderScreen({super.key});

  @override
  State<AddEditInstoreOrderScreen> createState() =>
      _AddEditInstoreOrderScreenState();
}

class _AddEditInstoreOrderScreenState extends State<AddEditInstoreOrderScreen> {
  int tabIndex = 1;
  bool isPreOrder = false;
  bool isError = false;
  String selectedOrderPlatform = '';
  String selectedOrderType = '';
  String selectedOrderStatus = '';
  String selectedPickUpMethod = '';
  DateTime selectedDate = DateTime.now();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final AddEditOrderController _controller = AddEditOrderController();

  List<StockOrderItemData> selectedStockList = [];
  double total = 0;
  double profit = 0;

  String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> getOrderStocks(
      List<StockOrderItemData> selectedStockList) {
    return selectedStockList.map((stockItem) {
      return {
        "recipe_id": stockItem.recipeID,
        "product_quantity": stockItem.quantity,
      };
    }).toList();
  }

  String convertOrderPlatform(String orderPlatform) {
    switch (orderPlatform) {
      case 'Store':
        return 'STORE';
      case 'Lineman':
        return 'LINEMAN';
      case 'Grab':
        return 'GRAB';
      case 'Facebook':
        return 'FACEBOOK';
      case 'Website':
        return 'WEBSITE';
      case 'Other':
        return 'OTHER';
      default:
        return '';
    }
  }

  String convertOrderType(String orderType) {
    switch (orderType) {
      case 'Personal':
        return 'PERSONAL';
      case 'Bulk-Order':
        return 'BULK_ORDER';
      case 'Special-day':
        return 'SPECIAL_DAY';
      case 'Festival':
        return 'FESTIVAL';
      case 'Other':
        return 'OTHER';
      default:
        return '';
    }
  }

  String convertOrderStatus(String orderStatus) {
    switch (orderStatus) {
      case 'Done':
        return 'DONE';
      case 'In-Process':
        return 'IN_PROCESS';
      case 'Cancel':
        return 'CANCEL';
      default:
        return '';
    }
  }

  String convertPickUpMethod(String pickUpMethod) {
    switch (pickUpMethod) {
      case 'In-Store':
        return 'IN_STORE';
      case 'Delivery':
        return 'DELIVERY';
      case 'Other':
        return 'OTHER';
      default:
        return '';
    }
  }

  String convertToISO8601(String inputDate) {
    try {
      DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      DateTime date = inputFormat.parse(inputDate);

      DateTime now = DateTime.now();

      DateTime combinedDate = DateTime(
          date.year, date.month, date.day, now.hour, now.minute, now.second);
      String isoDate = combinedDate.toUtc().toIso8601String();

      return isoDate;
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return '';
    }
  }

  String convertPickUpDate(String inputDate, String inputTime) {
    try {
      DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      DateTime date = inputFormat.parse(inputDate);

      DateFormat timeFormat = DateFormat('HH:mm');
      DateTime time = timeFormat.parse(inputTime);

      DateTime combinedDate = DateTime(
          date.year, date.month, date.day, time.hour, time.minute, time.second);
      String isoDate = combinedDate.toUtc().toIso8601String();

      return isoDate;
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return '';
    }
  }

  bool getIsDisabled() {
    return (selectedOrderPlatform.isEmpty ||
        _controller.orderDateController.text.isEmpty ||
        selectedOrderType.isEmpty ||
        _controller.orderTakenByController.text.isEmpty ||
        selectedStockList.isEmpty);
  }

  bool getPreOrderIsDisabled() {
    return (selectedOrderPlatform.isEmpty ||
        _controller.orderDateController.text.isEmpty ||
        selectedOrderType.isEmpty ||
        _controller.orderTakenByController.text.isEmpty ||
        _controller.pickUpDateController.text.isEmpty ||
        _controller.pickUpTimeController.text.isEmpty ||
        selectedPickUpMethod.isEmpty ||
        selectedOrderStatus.isEmpty ||
        selectedStockList.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            'Order',
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
                  setState(() {
                    selectedStockList = [];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(children: [
              Column(children: [
                const AddEditOrderTitle(title: 'Order Information'),
                const SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: Row(
                    children: [
                      BakingUpTabButton(
                          text: "In-Store",
                          isSelected: tabIndex == 1,
                          onClick: () {
                            setState(() {
                              tabIndex = 1;
                              isPreOrder = false;
                            });
                          }),
                      const SizedBox(
                        width: 40,
                      ),
                      BakingUpTabButton(
                          text: "Pre-Order",
                          isSelected: tabIndex == 2,
                          onClick: () {
                            setState(() {
                              tabIndex = 2;
                              isPreOrder = true;
                            });
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // In-store
                if (!isPreOrder) ...[
                  const AddEditOrderTitle(
                    title: 'Order Details',
                    fontSize: 18,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Order Platform',
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
                            BakingUpDropdown(
                              options: const [
                                'Store',
                                'Lineman',
                                'Grab',
                                'Facebook',
                                'Website',
                                'Other'
                              ],
                              topic: 'Order Platform',
                              selectedOption: selectedOrderPlatform,
                              onApply: (String value) {
                                setState(() {
                                  selectedOrderPlatform = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Order Date',
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
                            AddEditOrderDateField(
                              controller: _controller.orderDateController,
                              label: 'Order Date',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Type of Order',
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
                                'Personal',
                                'Bulk-Order',
                                'Special-day',
                                'Festival',
                                'Other'
                              ],
                              topic: 'Type of Order',
                              selectedOption: selectedOrderType,
                              onApply: (String value) {
                                setState(() {
                                  selectedOrderType = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Taken By',
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
                            AddEditOrderTextField(
                              label: "Name",
                              width: 150,
                              controller: _controller.orderTakenByController,
                            )
                          ],
                        ),
                        const SizedBox(height: 35),
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 90),
                              child: AddEditOrderTitle(
                                title: 'Adding Orders',
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              heightFactor: 0.5,
                              child: BakingUpCircularAddButton(
                                  onPressed: () async {
                                setState(() {
                                  selectedStockList = [];
                                  total = 0;
                                  profit = 0;
                                });
                                final List<StockOrderItemData>? selectedStocks =
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddEditOrderStockScreen(
                                                  isPreOrder: false,
                                                  oldSelectedStocks:
                                                      selectedStockList,
                                                )));
                                if (selectedStocks != null &&
                                    selectedStocks.isNotEmpty) {
                                  setState(() {
                                    selectedStockList = selectedStocks;

                                    for (var stock in selectedStockList) {
                                      total +=
                                          stock.sellingPrice * stock.quantity;
                                      profit += stock.profit * stock.quantity;
                                    }
                                  });
                                }
                              }),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemCount: selectedStockList.length,
                          itemBuilder: (context, index) {
                            return AddEditOrderStockMain(
                              stocks: selectedStockList,
                              index: index,
                              isPreOrder: false,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Total: ${NumberFormat('#,##0.00').format(total).replaceAll(removeTrailingZeros, '')}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Profit: ${NumberFormat('#,##0.00').format(profit).replaceAll(removeTrailingZeros, '')}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        const AddEditOrderTitle(title: "Note:"),
                        const SizedBox(height: 16),
                        AddEditOrderNoteTextField(
                          controller: _controller.noteController,
                        ),
                        const SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BakingUpLongActionButton(
                              title: 'Confirm',
                              color:
                                  getIsDisabled() ? greyColor : lightGreenColor,
                              isDisabled: getIsDisabled(),
                              dialogParams: BakingUpDialogParams(
                                title: 'Confirm Adding Order?',
                                imgUrl: 'assets/icons/order_check_icon.png',
                                content:
                                    'Are you sure you want to place your order?',
                                grayButtonTitle: 'Cancel',
                                secondButtonTitle: 'Confirm',
                                secondButtonColor: lightGreenColor,
                                grayButtonOnClick: () => Navigator.pop(context),
                                secondButtonOnClick: () async {
                                  debugPrint(
                                      _controller.orderDateController.text);
                                  try {
                                    final data = {
                                      "user_id": userId,
                                      "order_status": convertOrderStatus(
                                          selectedOrderStatus),
                                      "order_platform": convertOrderPlatform(
                                          selectedOrderPlatform),
                                      "order_date": convertToISO8601(
                                          _controller.orderDateController.text),
                                      "order_type":
                                          convertOrderType(selectedOrderType),
                                      "order_taken_by": _controller
                                          .orderTakenByController.text,
                                      "order_stocks":
                                          getOrderStocks(selectedStockList),
                                      "is_pre_order": false,
                                      "note_text":
                                          _controller.noteController.text,
                                      "note_create_at":
                                          DateTime.now().toUtc().toString()
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
                                        .post(
                                      "/api/order/addInStoreOrder",
                                      data: data,
                                    )
                                        .then(
                                      (value) {
                                        setState(() {
                                          selectedStockList = [];
                                        });
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        // ignore: use_build_context_synchronously
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
                                                "Sorry, we couldn’t add the in-store order due to a system error. Please try again later.",
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
                  )
                ],
                // Pre-order
                if (isPreOrder) ...[
                  const AddEditOrderTitle(
                    title: 'Customer Information',
                    fontSize: 18,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 16),
                            AddEditOrderTextField(
                              label: "Name",
                              width: 150,
                              controller: _controller.customerNameController,
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 16),
                            AddEditOrderTextField(
                              label: "Phone Number",
                              width: 150,
                              controller:
                                  _controller.customerPhoneNumberController,
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  const AddEditOrderTitle(
                    title: 'Order Details',
                    fontSize: 18,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Order Platform',
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
                            BakingUpDropdown(
                              options: const [
                                'Store',
                                'Lineman',
                                'Grab',
                                'Facebook',
                                'Website',
                                'Other'
                              ],
                              topic: 'Order Platform',
                              selectedOption: selectedOrderPlatform,
                              onApply: (String value) {
                                setState(() {
                                  selectedOrderPlatform = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Order Date',
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
                            AddEditOrderDateField(
                              controller: _controller.orderDateController,
                              label: 'Order Date',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Type of Order',
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
                                'Personal',
                                'Bulk-Order',
                                'Special-day',
                                'Festival',
                                'Other'
                              ],
                              topic: 'Type of Order',
                              selectedOption: selectedOrderType,
                              onApply: (String value) {
                                setState(() {
                                  selectedOrderType = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Pick-up Date',
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
                            AddEditOrderDateField(
                              controller: _controller.pickUpDateController,
                              label: 'Pick-up Date',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        //pick up time
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Pick-up Time',
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
                            AddEditOrderTimeField(
                              controller: _controller.pickUpTimeController,
                              label: 'Pick-up Time',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Pick-up Method',
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
                              options: const ['In-Store', 'Delivery', 'Other'],
                              topic: 'Pick-up Method',
                              selectedOption: selectedPickUpMethod,
                              onApply: (String value) {
                                setState(() {
                                  selectedPickUpMethod = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Taken By',
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
                            AddEditOrderTextField(
                              label: "Name",
                              width: 150,
                              controller: _controller.orderTakenByController,
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Order Status',
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
                                'Done',
                                'In-Process',
                                'Cancel',
                              ],
                              topic: 'Order Status',
                              selectedOption: selectedOrderStatus,
                              onApply: (String value) {
                                setState(() {
                                  selectedOrderStatus = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 90),
                              child: AddEditOrderTitle(
                                title: 'Adding Orders',
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              heightFactor: 0.5,
                              child: BakingUpCircularAddButton(
                                  onPressed: () async {
                                setState(() {
                                  selectedStockList = [];
                                  total = 0;
                                  profit = 0;
                                });
                                final List<StockOrderItemData>? selectedStocks =
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddEditOrderStockScreen(
                                                  isPreOrder: true,
                                                  oldSelectedStocks:
                                                      selectedStockList,
                                                )));
                                if (selectedStocks != null &&
                                    selectedStocks.isNotEmpty) {
                                  setState(() {
                                    selectedStockList = selectedStocks;

                                    for (var stock in selectedStockList) {
                                      total +=
                                          stock.sellingPrice * stock.quantity;
                                      profit += stock.profit * stock.quantity;
                                    }
                                  });
                                }
                              }),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemCount: selectedStockList.length,
                          itemBuilder: (context, index) {
                            return AddEditOrderStockMain(
                              stocks: selectedStockList,
                              index: index,
                              isPreOrder: true,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Total: ${NumberFormat('#,##0.00').format(total).replaceAll(removeTrailingZeros, '')}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Profit: ${NumberFormat('#,##0.00').format(profit).replaceAll(removeTrailingZeros, '')}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        const AddEditOrderTitle(title: "Note:"),
                        const SizedBox(height: 16),
                        AddEditOrderNoteTextField(
                          controller: _controller.noteController,
                        ),
                        const SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BakingUpLongActionButton(
                              title: 'Confirm',
                              color: getPreOrderIsDisabled()
                                  ? greyColor
                                  : lightGreenColor,
                              isDisabled: getPreOrderIsDisabled(),
                              dialogParams: BakingUpDialogParams(
                                title: 'Confirm Adding Order?',
                                imgUrl: 'assets/icons/order_check_icon.png',
                                content:
                                    'Are you sure you want to place your order?',
                                grayButtonTitle: 'Cancel',
                                secondButtonTitle: 'Confirm',
                                secondButtonColor: lightGreenColor,
                                grayButtonOnClick: () => Navigator.pop(context),
                                secondButtonOnClick: () async {
                                  debugPrint(
                                      _controller.orderDateController.text);
                                  try {
                                    final data = {
                                      "customer_name": _controller
                                          .customerNameController.text,
                                      "phone_number": _controller
                                          .customerPhoneNumberController.text,
                                      "user_id": userID,
                                      "order_status": convertOrderStatus(
                                          selectedOrderStatus),
                                      "order_platform": convertOrderPlatform(
                                          selectedOrderPlatform),
                                      "order_date": convertToISO8601(
                                          _controller.orderDateController.text),
                                      "order_type":
                                          convertOrderType(selectedOrderType),
                                      "order_taken_by": _controller
                                          .orderTakenByController.text,
                                      "pick_up_date": convertPickUpDate(
                                          _controller.pickUpDateController.text,
                                          _controller
                                              .pickUpTimeController.text),
                                      "pick_up_method": convertPickUpMethod(
                                          selectedPickUpMethod),
                                      "order_stocks":
                                          getOrderStocks(selectedStockList),
                                      "is_pre_order": true,
                                      "note_text":
                                          _controller.noteController.text,
                                      "note_create_at":
                                          DateTime.now().toUtc().toString()
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
                                        .post(
                                      "/api/order/addPreOrderOrder",
                                      data: data,
                                    )
                                        .then(
                                      (value) {
                                        setState(() {
                                          selectedStockList = [];
                                        });
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        // ignore: use_build_context_synchronously
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
                                                "Sorry, we couldn’t add the pre-order order due to a system error. Please try again later.",
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
                  )
                ]
              ]),
            ]),
          ),
        ));
  }
}

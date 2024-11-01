import 'dart:developer';

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/add_edit_order_controller.dart';
import 'package:bakingup_frontend/models/stock_order_page.dart';
import 'package:bakingup_frontend/screens/auth/add_edit_order_stock_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_date_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_note_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_stock_main.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_text_field.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_title.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_tab_button.dart';
import 'package:flutter/material.dart';

class AddEditInstoreOrderScreen extends StatefulWidget {
  const AddEditInstoreOrderScreen({super.key});

  @override
  State<AddEditInstoreOrderScreen> createState() =>
      _AddEditInstoreOrderScreenState();
}

class _AddEditInstoreOrderScreenState extends State<AddEditInstoreOrderScreen> {
  int tabIndex = 1;
  bool isPreOrder = false;
  final bool _isEdit = false;
  bool isError = false;
  String selectedOrderPlatform = '';
  String selectedOrderType = '';
  String selectedOrderStatus = '';
  DateTime selectedDate = DateTime.now();

  final AddEditOrderController _controller = AddEditOrderController();

  List<StockOrderItemData> selectedStockList = [];
  List<StockOrderItemData> originalStockList = [];
  double total = 0;
  double profit = 0;

  String userID = "1";

  @override
  void initState() {
    super.initState();
    _fetchAllStocks();
  }

  Future<void> _fetchAllStocks() async {
    try {
      final response = await NetworkService.instance.get(
          '/api/stock/getAllStocksForOrder/?user_id=$userID');

      final stockOrderPageResponse = StockOrderPageResponse.fromJson(response);
      final data = stockOrderPageResponse.data;

      setState(() {
        originalStockList = data.stocks;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
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
      case 'Spacial-day':
        return 'SPACIAL_DAY';
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
                if (!isPreOrder) ...[
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
                                'Spacial-day',
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
                                                const AddEditOrderStockScreen(
                                                    isPreOrder: false)));
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
                            var maxValue = 0;
                            for (var stock in originalStockList) {
                              if (stock.recipeID ==
                                  selectedStockList[index].recipeID) {
                                maxValue = stock.quantity;
                              }
                            }
                            return AddEditOrderStockMain(
                              stocks: selectedStockList,
                              index: index,
                              isPreOrder: false,
                              maxQuantity: maxValue,
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
                                  'Total: $total',
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
                                  'Profit: $profit',
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
                              color: lightGreenColor,
                              dialogParams: BakingUpDialogParams(
                                title: _isEdit
                                    ? 'Confirm Order Changes?'
                                    : 'Confirm Adding Order?',
                                imgUrl: 'assets/icons/order_check_icon.png',
                                content: _isEdit
                                    ? 'You\'re about to save edited order.'
                                    : 'Are you sure you want to place your order?',
                                grayButtonTitle: 'Cancel',
                                secondButtonTitle: 'Confirm',
                                secondButtonColor: lightGreenColor,
                                grayButtonOnClick: () => Navigator.pop(context),
                                secondButtonOnClick: () async {
                                  try {
                                    final data = {
                                      "user_id": "1",
                                      "order_status": convertOrderStatus(
                                          selectedOrderStatus),
                                      "order_platform": convertOrderPlatform(
                                          selectedOrderPlatform),
                                      "order_date":
                                          _controller.orderDateController.text,
                                      "order_type":
                                          convertOrderType(selectedOrderType),
                                      "order_taken_by": _controller
                                          .orderTakenByController.text,
                                      "order_stocks": getOrderStocks(selectedStockList),
                                      "is_pre_order": false,
                                      "note_text":
                                          _controller.noteController.text,
                                      "note_create_at":
                                          DateTime.now().toUtc().toString()
                                    };
                                    await NetworkService.instance
                                        .post(
                                      "/api/order/addInStoreOrder",
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
              ]),
            ]),
          ),
        ));
  }
}

import 'dart:developer';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:bakingup_frontend/enum/pick_up_method.dart';
import 'package:bakingup_frontend/models/instore_order_detail.dart';
import 'package:bakingup_frontend/models/preorder_order_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/string_extensions.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_note.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_date.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_list.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_platform.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_taken_by.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_pick_up_method.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_profit.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_text.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_total.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_type_of_order.dart';
import 'package:bakingup_frontend/widgets/order_detail/status_dropdown.dart';
import 'package:flutter/material.dart';

class PreorderOrderDetailScreen extends StatefulWidget {
  final String? orderId;
  const PreorderOrderDetailScreen({super.key, this.orderId});

  @override
  State<PreorderOrderDetailScreen> createState() =>
      _PreorderOrderDetailScreenState();
}

class _PreorderOrderDetailScreenState extends State<PreorderOrderDetailScreen> {
  bool isLoading = true;
  bool isError = false;
  int orderIndex = 1;
  OrderStatus orderStatus = OrderStatus.inProcess;
  OrderPlatform orderPlatform = OrderPlatform.store;
  String orderDate = '';
  String orderTime = '';
  String pickUpDate = '';
  String pickUpTime = '';
  PickUpMethod pickUpMethod = PickUpMethod.inStore;
  OrderType orderType = OrderType.personal;
  String orderTakenBy = '';
  List<OrderStock> orderStockList = [];
  double total = 0.0;
  double profit = 0.0;
  String? orderNoteText = '';
  String? orderNoteCreateAt = '';
  String selectedStatus = '';
  String? customerName = '';
  String? customerPhone = '';

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await NetworkService.instance.get(
          '/api/order/getOrderDetail/?order_id=${widget.orderId}');
      final preorderOrderDetailResponse =
          PreorderOrderDetailResponse.fromJson(response);
      final data = preorderOrderDetailResponse.data;
      setState(() {
        orderIndex = data.orderIndex;
        customerName = data.customerName;
        customerPhone = data.phoneNumber;
        orderStatus = data.orderStatus;
        orderPlatform = data.orderPlatform;
        orderDate = data.orderDate;
        orderTime = data.orderTime;
        orderType = data.orderType;
        pickUpDate = data.pickUpDate;
        pickUpTime = data.pickUpTime;
        pickUpMethod = data.pickUpMethod;
        orderTakenBy = data.orderTakenBy;
        orderStockList = data.orderStockList;
        total = data.total;
        profit = data.profit;
        orderNoteText = data.orderNoteText ?? '';
        orderNoteCreateAt = data.orderNoteCreateAt ?? '';
        selectedStatus = orderStatus.toString().split('.').last.capitalize();
        
        if (selectedStatus == 'Inprocess') {
          selectedStatus = 'In-Process';
        }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Order #$orderIndex',
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Date: $orderDate $orderTime',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                color: blackColor,
              ),
            )
          ],
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
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Customer Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderDetailText(
                        isLoading: isLoading,
                        text: customerName,
                        label: 'Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    OrderDetailText(
                        isLoading: isLoading,
                        text: customerPhone,
                        label: 'Phone Number'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  StatusDropdown(
                      options: const ['Done', 'In-Process', 'Cancel'],
                      orderStatus: orderStatus,
                      topic: 'Order status',
                      selectedOption: selectedStatus,
                      onApply: (String value) async {
                        try {
                          final data = {
                            "order_id": widget.orderId,
                            "order_status": convertOrderStatus(value),
                          };
                          await NetworkService.instance
                              .put(
                                  "/api/order/editOrderStatus",
                                  data: data)
                              .then((res) {
                            setState(() {
                              selectedStatus = value;
                            });
                          });
                        } catch (e) {
                          log(e.toString());
                          Navigator.of(context).overlay!.insert(
                            OverlayEntry(
                              builder: (BuildContext context) {
                                return const BakingUpErrorTopNotification(
                                  message:
                                      "Sorry, we couldn’t change the order status due to a system error. Please try again later.",
                                );
                              },
                            ),
                          );
                        }
                      })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderDetailOrderPlatform(
                      isLoading: isLoading,
                      orderPlatform: orderPlatform,
                    ),
                    OrderDetailOrderDate(
                        isLoading: isLoading, orderDate: orderDate),
                    OrderDetailTypeOfOrder(
                        isLoading: isLoading, orderType: orderType),
                    const SizedBox(
                      height: 15,
                    ),
                    OrderDetailText(
                        isLoading: isLoading,
                        text: pickUpDate,
                        label: 'Pick-Up Date'),
                    OrderDetailText(
                        isLoading: isLoading,
                        text: pickUpTime,
                        label: 'Pick-Up Time'),
                    OrderDetailPickUpMethod(
                        isLoading: isLoading, pickUpMethod: pickUpMethod),
                    const SizedBox(
                      height: 15,
                    ),
                    OrderDetailOrderTakenBy(
                        isLoading: isLoading, name: orderTakenBy),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OrderDetailOrderList(
                orderStockList: orderStockList,
                isLoading: isLoading,
                isPreOrder: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OrderDetailTotal(isLoading: isLoading, total: total),
                    OrderDetailProfit(isLoading: isLoading, profit: profit),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OrderDetailNote(
                isLoading: isLoading,
                orderNoteText: orderNoteText,
                orderNoteCreateAt: orderNoteCreateAt,
              )
            ],
          ),
        ),
      ),
    );
  }
}

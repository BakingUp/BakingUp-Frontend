import 'dart:developer';

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:bakingup_frontend/models/instore_order_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/string_extensions.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_note.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_date.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_list.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_platform.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_taken_by.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_profit.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_total.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_type_of_order.dart';
import 'package:bakingup_frontend/widgets/order_detail/status_dropdown.dart';
import 'package:flutter/material.dart';

class InStoreOrderDetailScreen extends StatefulWidget {
  final String? orderId;
  const InStoreOrderDetailScreen({super.key, this.orderId});

  @override
  State<InStoreOrderDetailScreen> createState() =>
      _InStoreOrderDetailScreenState();
}

class _InStoreOrderDetailScreenState extends State<InStoreOrderDetailScreen> {
  bool isLoading = true;
  bool isError = false;
  // bool _isEdit = false;
  int orderIndex = 1;
  OrderStatus orderStatus = OrderStatus.done;
  OrderPlatform orderPlatform = OrderPlatform.store;
  String orderDate = '';
  String orderTime = '';
  OrderType orderType = OrderType.personal;
  String orderTakenBy = '';
  List<OrderStock> orderStockList = [];
  double total = 0.0;
  double profit = 0.0;
  String? orderNoteText = '';
  String? orderNoteCreateAt = '';
  String selectedStatus = '';

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
      final instoreOrderDetailResponse =
          InstoreOrderDetailResponse.fromJson(response);
      final data = instoreOrderDetailResponse.data;
      setState(() {
        orderIndex = data.orderIndex;
        orderStatus = data.orderStatus;
        orderPlatform = data.orderPlatform;
        orderDate = data.orderDate;
        orderTime = data.orderTime;
        orderType = data.orderType;
        orderTakenBy = data.orderTakenBy;
        orderStockList = data.orderStockList;
        total = data.total;
        profit = data.profit;
        orderNoteText = data.orderNoteText ?? '';
        orderNoteCreateAt = data.orderNoteCreateAt ?? '';
        selectedStatus = orderStatus.toString().split('.').last.capitalize();
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
                      options: const ['Done', 'Cancel'],
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
                          // ignore: use_build_context_synchronously
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                        OrderDetailOrderTakenBy(
                            isLoading: isLoading, name: orderTakenBy),
                      ],
                    ),
                    Container(
                      child: orderPlatform == OrderPlatform.store
                          ? Image.asset(
                              'assets/icons/store.png',
                              width: 45,
                              height: 45,
                            )
                          : orderPlatform == OrderPlatform.lineman ||
                                  orderPlatform == OrderPlatform.grab
                              ? Image.asset(
                                  'assets/icons/delivery.png',
                                  width: 40,
                                  height: 40,
                                )
                              : const SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OrderDetailOrderList(
                orderStockList: orderStockList,
                isLoading: isLoading,
                isPreOrder: false,
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

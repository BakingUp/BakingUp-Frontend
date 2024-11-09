import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:bakingup_frontend/models/order.dart';
import 'package:bakingup_frontend/screens/instore_order_detail_screen.dart';
import 'package:bakingup_frontend/screens/preorder_order_detail_screen.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final List<OrderInfo> orderList;
  final int index;
  final bool isLoading;
  final Future<void> Function() fetchOrderList;

  const OrderItem(
      {super.key,
      required this.orderList,
      required this.index,
      required this.isLoading,
      required this.fetchOrderList});

  @override
  Widget build(BuildContext context) {
    return orderList[index].isPreOrder
        ?
        // Preorder
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreorderOrderDetailScreen(
                      orderId: orderList[index].orderId),
                ),
              ).then((value) {
                fetchOrderList();
              });
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              decoration: BoxDecoration(
                color: pinkColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: orderList[index].orderStatus ==
                              OrderStatus.done
                          ? const AssetImage(
                              'assets/icons/order_status_done.png')
                          : orderList[index].orderStatus == OrderStatus.cancel
                              ? const AssetImage(
                                  'assets/icons/order_status_cancel.png')
                              : const AssetImage(
                                  'assets/icons/order_status_inprocess.png'),
                      radius: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${orderList[index].orderIndex}',
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Total: ${orderList[index].total}',
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Order Date: ${orderList[index].orderDate}',
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Pick-Up Date: ${orderList[index].pickUpDate}',
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        :
        // in-store
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InStoreOrderDetailScreen(
                            orderId: orderList[index].orderId,
                          ))).then((value) {
                fetchOrderList();
              });
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              decoration: BoxDecoration(
                color: beigeColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: orderList[index].orderStatus ==
                              OrderStatus.done
                          ? const AssetImage(
                              'assets/icons/order_status_done.png')
                          : orderList[index].orderStatus == OrderStatus.cancel
                              ? const AssetImage(
                                  'assets/icons/order_status_cancel.png')
                              : const AssetImage(
                                  'assets/icons/order_status_inprocess.png'),
                      radius: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${orderList[index].orderIndex}',
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Total: ${orderList[index].total}',
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Date: ${orderList[index].orderDate}',
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: orderList[index].orderPlatform == OrderPlatform.store
                        ? Image.asset(
                            'assets/icons/store.png',
                            width: 45,
                            height: 45,
                          )
                        : orderList[index].orderPlatform ==
                                    OrderPlatform.lineman ||
                                orderList[index].orderPlatform ==
                                    OrderPlatform.grab
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
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          );
  }
}

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/order.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/order/order_item.dart';
import 'package:bakingup_frontend/widgets/order/instore_order_item_loading.dart';
import 'package:bakingup_frontend/widgets/order/preorder_item_loading.dart';
import 'package:flutter/material.dart';

class OrderInfoList extends StatefulWidget {
  final List<OrderInfo> orderList;
  final bool isLoading;
  final bool isPreOrder;
  final Future<void> Function() fetchOrderList;

  const OrderInfoList(
      {super.key,
      required this.orderList,
      required this.isLoading,
      required this.isPreOrder,
      required this.fetchOrderList});

  @override
  State<OrderInfoList> createState() => _OrderInfoListState();
}

class _OrderInfoListState extends State<OrderInfoList> {
  Future<void> _deleteOrder(String orderId) async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    try {
      await NetworkService.instance.delete(
          '/api/order/deleteOrder?order_id=$orderId');

      if (mounted) {
        Navigator.of(context).pop();
        widget.fetchOrderList();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        OverlayEntry errorNotification = OverlayEntry(
          builder: (BuildContext context) {
            return const BakingUpErrorTopNotification(
              message:
                  "Sorry, we couldn’t delete this order due to a system error. Please try again later.",
            );
          },
        );
        Navigator.of(context).overlay?.insert(errorNotification);
        Future.delayed(const Duration(seconds: 3), () {
          if (errorNotification.mounted) {
            errorNotification.remove();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    if (widget.isPreOrder) {
                      return const PreOrderItemLoading();
                    } else {
                      return const InStoreOrderItemLoading();
                    }
                  },
                )))
        : Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      itemCount: widget.orderList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(widget.orderList[index].orderId),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: redColor,
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BakingUpDialog(
                                    title: "Confirm Delete?",
                                    imgUrl: "assets/icons/delete_warning.png",
                                    content:
                                        "Are you sure you want to delete this order?",
                                    grayButtonTitle: "Cancel",
                                    secondButtonTitle: "Delete",
                                    secondButtonColor: lightRedColor,
                                    grayButtonOnClick: () {
                                      Navigator.pop(context);
                                    },
                                    secondButtonOnClick: () async {
                                      Navigator.of(context).pop();
                                      await _deleteOrder(
                                          widget.orderList[index].orderId);
                                    },
                                  );
                                });
                          },
                          onDismissed: (direction) {
                            setState(() {
                              widget.orderList.removeAt(index);
                            });
                          },
                          child: OrderItem(
                            orderList: widget.orderList,
                            index: index,
                            isLoading: widget.isLoading,
                            fetchOrderList: widget.fetchOrderList,
                          ),
                        );
                      },
                    ))));
  }
}

import 'package:bakingup_frontend/models/instore_order_detail.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_stock.dart';
import 'package:bakingup_frontend/widgets/order_detail/order_detail_order_stock_loading.dart';
import 'package:flutter/material.dart';

class OrderDetailOrderList extends StatefulWidget {
  final List<OrderStock> orderStockList;
  final bool isLoading;
  final bool isPreOrder;

  const OrderDetailOrderList(
      {super.key, required this.orderStockList, required this.isLoading, required this.isPreOrder});

  @override
  State<OrderDetailOrderList> createState() => _OrderDetailOrderListState();
}

class _OrderDetailOrderListState extends State<OrderDetailOrderList> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: 1,
              itemBuilder: (context, index) {
                return OrderDetailOrderStockLoading(isPreOrder: widget.isPreOrder);
              },
            ),
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: widget.orderStockList.length,
                itemBuilder: (context, index) {
                  return OrderDetailOrderStock(
                      orderStockList: widget.orderStockList, index: index, isPreOrder: widget.isPreOrder,);
                }),
          );
  }
}

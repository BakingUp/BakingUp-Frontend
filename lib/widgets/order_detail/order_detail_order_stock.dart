import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/instore_order_detail.dart';
import 'package:flutter/material.dart';

class OrderDetailOrderStock extends StatelessWidget {
  final List<OrderStock> orderStockList;
  final int index;
  final bool isPreOrder;

  const OrderDetailOrderStock(
      {super.key, required this.orderStockList, required this.index, required this.isPreOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      decoration: BoxDecoration(
        color: isPreOrder ? pinkColor : beigeColor,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  orderStockList[index].imgUrl,
                  width: 90,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 16.0)),
            ],
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${orderStockList[index].quantity}x',
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        orderStockList[index].name,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${orderStockList[index].stockPrice} ฿',
            style: TextStyle(
              color: blackColor,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 20.0))
        ],
      ),
    );
  }
}

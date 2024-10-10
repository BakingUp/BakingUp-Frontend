import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailTypeOfOrder extends StatelessWidget {
  final bool isLoading;
  final OrderType orderType;

  const OrderDetailTypeOfOrder(
      {super.key, required this.isLoading, required this.orderType});

  String changeToString(OrderType orderType) {
    switch (orderType) {
      case OrderType.PERSONAL:
        return 'Personal';
      case OrderType.BULK_ORDER:
        return 'Bulk Order';
      case OrderType.FESTIVAL:
        return 'Festival';
      case OrderType.SPECIAL_DAY:
        return 'Spacial Day';
      default:
        return 'Other';
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 100,
                  height: 16,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 7.0),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Type of Order:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                changeToString(orderType),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
  }
}

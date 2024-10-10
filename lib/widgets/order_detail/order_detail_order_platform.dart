import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailOrderPlatform extends StatelessWidget {
  final bool isLoading;
  final OrderPlatform orderPlatform;
  const OrderDetailOrderPlatform(
      {super.key, required this.isLoading, required this.orderPlatform});

  String changeToString(OrderPlatform orderPlatform) {
    switch (orderPlatform) {
      case OrderPlatform.STORE:
        return 'Store';
      case OrderPlatform.FACEBOOK:
        return 'Facebook';
      case OrderPlatform.GRAB:
        return 'Grab';
      case OrderPlatform.LINEMAN:
        return 'Lineman';
      case OrderPlatform.WEBSITE:
        return 'Website';
      case OrderPlatform.OTHER:
        return 'Other';
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
                'Order Platform:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                changeToString(orderPlatform),
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

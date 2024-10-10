import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailOrderDate extends StatelessWidget {
  final bool isLoading;
  final String orderDate;
  const OrderDetailOrderDate(
      {super.key, required this.isLoading, required this.orderDate});

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
                'Order Date:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                orderDate,
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

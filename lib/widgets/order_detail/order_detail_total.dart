import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailTotal extends StatelessWidget {
  final bool isLoading;
  final double total;
  const OrderDetailTotal(
      {super.key, required this.isLoading, required this.total});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 80,
                  height: 16,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 7.0),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                total.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
  }
}

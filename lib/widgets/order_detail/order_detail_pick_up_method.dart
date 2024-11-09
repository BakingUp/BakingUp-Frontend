import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/pick_up_method.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailPickUpMethod extends StatelessWidget {
  final bool isLoading;
  final PickUpMethod pickUpMethod;
  const OrderDetailPickUpMethod({super.key, required this.isLoading, required this.pickUpMethod});

  String changeToString(PickUpMethod pickUpMethod) {
    switch (pickUpMethod) {
      case PickUpMethod.delivery:
        return 'Delivery';
      case PickUpMethod.inStore:
        return 'In-Store';
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
                'Pick-up Method:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                changeToString(pickUpMethod),
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
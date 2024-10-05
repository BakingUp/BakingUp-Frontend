import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailInformationBakeryQuantity extends StatelessWidget {
  final bool isLoading;
  final int quantity;
  const StockDetailInformationBakeryQuantity({
    super.key,
    required this.isLoading,
    required this.quantity,
  });

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
                  margin: const EdgeInsets.only(top: 7.0),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quantity:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                quantity.toString(),
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

import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailInformationBakerySellByDate extends StatelessWidget {
  final bool isLoading;
  final String sellByDate;
  const StockDetailInformationBakerySellByDate({
    super.key,
    required this.isLoading,
    required this.sellByDate,
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
                  width: 200,
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
                'Sell-By Date:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                sellByDate,
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

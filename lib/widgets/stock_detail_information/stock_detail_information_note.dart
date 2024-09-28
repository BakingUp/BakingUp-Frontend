import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailInformationNote extends StatelessWidget {
  final String note;
  final String createdAt;
  final bool isLoading;

  const StockDetailInformationNote({
    super.key,
    required this.note,
    required this.createdAt,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 16),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: beigeColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: 120,
                          height: 13,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 6.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Shimmer.fromColors(
                      baseColor: greyColor,
                      highlightColor: whiteColor,
                      child: Container(
                        width: 80,
                        height: 13,
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 6.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 16),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: beigeColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        note,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      createdAt,
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

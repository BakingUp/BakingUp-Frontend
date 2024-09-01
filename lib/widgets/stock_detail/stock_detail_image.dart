import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailImage extends StatelessWidget {
  final String? stockUrl;
  final bool isLoading;

  const StockDetailImage({
    super.key,
    required this.stockUrl,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width / 0.8),
              color: Colors.white,
            ),
          ),
        ),
        if (isLoading == false) ...[
          if (stockUrl != '') ...[
            Image.network(
              stockUrl!,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ] else ...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width / 0.8),
              color: greyColor,
            )
          ]
        ]
      ],
    );
  }
}

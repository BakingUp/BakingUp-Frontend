import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_edit_stock_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailStockName extends StatelessWidget {
  final String stockName;
  final bool isLoading;

  const StockDetailStockName({
    super.key,
    required this.stockName,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 200,
              height: 30,
              color: Colors.white,
            ),
          )
        : Row(
            children: [
              Text(
                stockName,
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
              ),
              const StockDetailEditStockButton(),
            ],
          );
  }
}

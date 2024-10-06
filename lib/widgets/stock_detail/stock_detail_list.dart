import 'package:bakingup_frontend/models/stock_detail.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_detail.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_detail_loading.dart';
import 'package:flutter/material.dart';

class StockDetailList extends StatelessWidget {
  final List<StockDetail> stockDetails;
  final bool isLoading;

  const StockDetailList({
    super.key,
    required this.stockDetails,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const StockDetailDetailLoading();
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: stockDetails.length,
              itemBuilder: (context, index) {
                return StockDetailDetail(
                  stockDetails: stockDetails[index],
                );
              },
            ),
    );
  }
}

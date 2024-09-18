import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/widgets/stock/stock_item.dart';
import 'package:bakingup_frontend/widgets/stock/stock_item_loading.dart';
import 'package:flutter/material.dart';

class StockList extends StatelessWidget {
  final List<StockItemData> stockList;
  final bool isLoading;
  const StockList(
      {super.key, required this.stockList, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const StockItemLoading();
            },
          ))
        : Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            itemCount: stockList.length,
            itemBuilder: (context, index) {
              return StockItem(
                stockList: stockList,
                index: index,
              );
            },
          ));
  }
}

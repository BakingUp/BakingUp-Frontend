import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/stock/stock_item.dart';
import 'package:bakingup_frontend/widgets/stock/stock_item_loading.dart';
import 'package:flutter/material.dart';

class StockList extends StatefulWidget {
  final List<StockItemData> stockList;
  final bool isLoading;
  const StockList({
    super.key,
    required this.isLoading,
    required this.stockList,
  });

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  Future<void> _deleteStock(String stockId) async {
    showDialog(
      context: context,
      barrierColor: const Color(0xC7D9D9D9),
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    await NetworkService.instance
        .delete('/api/stock/deleteStock?recipe_id=$stockId');
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const StockItemLoading();
                  },
                )))
        : Expanded(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  itemCount: widget.stockList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(widget.stockList[index].stockID),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: redColor,
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BakingUpDialog(
                                title: "Confirm Delete?",
                                imgUrl: "assets/icons/delete_warning.png",
                                content:
                                    "Are you sure you want to delete this stock?",
                                grayButtonTitle: "Cancel",
                                secondButtonTitle: "Delete",
                                secondButtonColor: lightRedColor,
                                grayButtonOnClick: () {
                                  Navigator.pop(context);
                                },
                                secondButtonOnClick: () {
                                  Navigator.of(context).pop();
                                  _deleteStock(widget.stockList[index].stockID)
                                      .then((_) {
                                    Navigator.of(context).pop();
                                  }).catchError((error) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .overlay!
                                        .insert(OverlayEntry(
                                      builder: (BuildContext context) {
                                        return const BakingUpErrorTopNotification(
                                          message:
                                              "Sorry, we couldn’t delete the stock due to a system error. Please try again later.",
                                        );
                                      },
                                    ));
                                  });
                                },
                              );
                            });
                      },
                      onDismissed: (direction) {
                        setState(() {
                          widget.stockList.removeAt(index);
                        });
                      },
                      child: StockItem(
                        stockList: widget.stockList,
                        index: index,
                      ),
                    );
                  },
                )));
  }
}

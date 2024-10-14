import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:bakingup_frontend/widgets/baking_up_error_top_notification.dart';
import 'package:bakingup_frontend/widgets/baking_up_loading_dialog.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_detail.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_detail_loading.dart';
import 'package:flutter/material.dart';

class StockDetailList extends StatefulWidget {
  final List<StockDetail> stockDetails;
  final bool isLoading;
  final Function(int) onDelete;

  const StockDetailList({
    super.key,
    required this.stockDetails,
    required this.isLoading,
    required this.onDelete,
  });

  @override
  State<StockDetailList> createState() => _StockDetailListState();
}

class _StockDetailListState extends State<StockDetailList> {
  Future<void> _deleteStockBatch(String stockDetailId) async {
    showDialog(
      context: context,
      barrierColor: greyColor,
      builder: (BuildContext context) {
        return const BakingUpLoadingDialog();
      },
    );

    await NetworkService.instance.delete(
        '/api/stock/deleteStockBatch?stock_detail_id=$stockDetailId');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.isLoading
          ? ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const StockDetailDetailLoading();
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: widget.stockDetails.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(widget.stockDetails[index].stockDetailId),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                  "Are you sure you want to delete this ingredient stock?",
                              grayButtonTitle: "Cancel",
                              secondButtonTitle: "Delete",
                              secondButtonColor: lightRedColor,
                              grayButtonOnClick: () {
                                Navigator.pop(context);
                              },
                              secondButtonOnClick: () {
                                Navigator.of(context).pop();
                                _deleteStockBatch(widget
                                        .stockDetails[index].stockDetailId)
                                    .then((_) {
                                  Navigator.of(context).pop();
                                  widget.onDelete(index);
                                }).catchError(
                                  (error) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).overlay!.insert(
                                      OverlayEntry(
                                        builder: (BuildContext context) {
                                          return const BakingUpErrorTopNotification(
                                            message:
                                                "Sorry, we couldn’t delete the stock batch due to a system error. Please try again later.",
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          });
                    },
                    child: StockDetailDetail(
                      stockDetails: widget.stockDetails[index],
                    ));
              },
            ),
    );
  }
}

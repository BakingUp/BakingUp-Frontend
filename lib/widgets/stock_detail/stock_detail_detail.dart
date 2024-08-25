import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/stock_detail/lst_status_indicator.dart';
import 'package:flutter/material.dart';

class StockDetailDetail extends StatelessWidget {
  final List<StockDetail> stockDetails;
  final int index;

  const StockDetailDetail(
      {super.key, required this.stockDetails, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
      decoration: BoxDecoration(
        color: stockDetails[index].lstStatus == LSTStatus.black
            ? greyColor
            : beigeColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              LSTStatusIndicator(status: stockDetails[index].lstStatus),
              const Padding(padding: EdgeInsets.only(right: 20.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quantity: ${stockDetails[index].quantity}',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Sell-By Date: ${stockDetails[index].sellByDate}',
                    style: TextStyle(
                      color: stockDetails[index].lstStatus == LSTStatus.black
                          ? redColor
                          : blackColor,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StockItem extends StatelessWidget {
  final List<StockItemData> stockList;
  final int index;

  const StockItem({super.key, required this.stockList, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockDetailScreen(
                      recipeId: stockList[index].stockID,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: BoxDecoration(
          color: beigeColor,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: 90,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.network(
                          stockList[index].stockUrl,
                          width: 90,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/icons/no-image.jpg',
                              width: 90,
                              height: 60,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(right: 16.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stockList[index].stockName,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                      ),
                      Text(
                        'Quantity: ${stockList[index].quantity}  LST: ${stockList[index].lst}',
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                      ),
                      Text(
                        'Selling price: ${stockList[index].sellingPrice % 1 == 0 ? stockList[index].sellingPrice.ceil() : stockList[index].sellingPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: blackColor,
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
            ),
            Container(
              width: 40,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(13),
                      topRight: Radius.circular(13)),
                  color: stockList[index].lstStatus == LSTStatus.black
                      ? blackColor
                      : stockList[index].lstStatus == LSTStatus.red
                          ? redColor
                          : stockList[index].lstStatus == LSTStatus.yellow
                              ? yellowColor
                              : greenColor),
            ),
          ],
        ),
      ),
    );
  }
}

// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_back_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_button.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_back_button_container.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_image.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_image_container.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_container.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_lst.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_notify_me.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_quantity.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_selling_price.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_stock_name.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_list.dart';
import 'package:bakingup_frontend/enum/lst_status.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  String stockUrl =
      'https://images.immediate.co.uk/production/volatile/sites/30/2021/09/butter-cookies-262c4fd.jpg';
  String stockName = 'Butter Cookies';
  int quantity = 30;
  double ingredientLessThan = 10;
  int lst = 3;
  double price = 50;
  List<StockDetail> stockDetails = [
    StockDetail(
      stockId: '1',
      quantity: 10,
      sellByDate: '29/06/2024',
      lstStatus: LSTStatus.red,
    ),
    StockDetail(
      stockId: '2',
      quantity: 12,
      sellByDate: '29/06/2024',
      lstStatus: LSTStatus.green,
    ),
    StockDetail(
      stockId: '3',
      quantity: 14,
      sellByDate: '29/06/2024',
      lstStatus: LSTStatus.yellow,
    ),
    StockDetail(
      stockId: '4',
      quantity: 16,
      sellByDate: '29/06/2024',
      lstStatus: LSTStatus.black,
    ),
  ];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          StockDetailImageContainer(
            child: StockDetailImage(
              stockUrl: stockUrl,
              isLoading: isLoading,
            ),
          ),
          const StockDetailBackButtonContainer(
            children: [
              BakingUpCircularBackButton(),
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.5) + 125,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width / 1.5) -
                  125,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BakingUpFilterButton(),
                      ],
                    ),
                  ),
                  StockDetailList(
                    stockDetails: stockDetails,
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          ),
          StockDetailContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        StockDetailStockName(
                          stockName: stockName,
                          isLoading: isLoading,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                        ),
                      ],
                    ),
                    const BakingUpCircularAddButton(),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StockDetailQuantity(
                            quantity: quantity, isLoading: isLoading),
                        StockDetailSellingPrice(
                            price: price, isLoading: isLoading),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StockDetailLst(
                          lst: lst,
                          isLoading: isLoading,
                        ),
                        StockDetailNotifyMe(
                          ingredientLessThan: ingredientLessThan,
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Temporary class to simulate the data
class StockDetail {
  final String stockId;
  final int quantity;
  final String sellByDate;
  final LSTStatus lstStatus;

  StockDetail({
    required this.stockId,
    required this.quantity,
    required this.sellByDate,
    required this.lstStatus,
  });
}

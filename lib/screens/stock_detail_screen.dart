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
import 'package:bakingup_frontend/models/stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  final String recipeId = '1';
  String stockUrl = '';
  String stockName = '';
  int quantity = 0;
  int stockLessThan = 0;
  int lst = 0;
  double price = 0.0;
  List<StockDetail> stockDetails = [];
  bool isLoading = true;
  bool isError = false;

    @override
  void initState() {
    super.initState();
    _fetchStockDetails();
  }

  Future<void> _fetchStockDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/stock/getStockDetail?recipe_id=$recipeId',
      );
      final stockDetailResponse =
          StockDetailResponse.fromJson(response);
      final data = stockDetailResponse.data;
      setState(() {
        stockUrl = data.stockUrl.first;
        stockName = data.stockName;
        quantity = data.quantity;
        lst = data.lst;
        price = data.sellingPrice;
        stockLessThan = data.stockLessThan;
        stockDetails = data.stockDetails;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                          stockLessThan: stockLessThan,
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
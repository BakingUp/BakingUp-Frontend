import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock_order_page.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_stock_details.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:flutter/material.dart';

class AddEditOrderStockScreen extends StatefulWidget {
  final bool isPreOrder;
  const AddEditOrderStockScreen({super.key, required this.isPreOrder});

  @override
  State<AddEditOrderStockScreen> createState() =>
      _AddEditOrderStockScreenState();
}

class _AddEditOrderStockScreenState extends State<AddEditOrderStockScreen> {
  bool isLoading = true;
  bool isError = false;
  bool noResult = false;
  List<StockOrderItemData> stocks = [];
  List<StockOrderItemData> preorderStocks = [];
  List<StockOrderItemData> instoreStocks = [];
  List<StockOrderItemData> filteredStocks = [];

  List<StockOrderItemData> selectedStocks = [];
  List<StockOrderItemData> filteredSelectedStocks = [];
  final TextEditingController _searchController = TextEditingController();
  // FocusNode _searchFocusNode = FocusNode();

  String userID = "1";

  @override
  void initState() {
    super.initState();
    _fetchAllStocks();
  }

  Future<void> _fetchAllStocks() async {
    setState(() {
      isLoading = true;
      isError = false;
      _searchController.clear();
      noResult = false;
      stocks = [];
      instoreStocks = [];
      preorderStocks = [];
    });

    try {
      final response = await NetworkService.instance.get(
          '/api/stock/getAllStocksForOrder/?user_id=$userID');

      final stockOrderPageResponse = StockOrderPageResponse.fromJson(response);
      final data = stockOrderPageResponse.data;

      setState(() {
        preorderStocks = data.stocks;

        if (widget.isPreOrder) {
          //pre-order
          filteredStocks = preorderStocks;
          if (stockOrderPageResponse.status == 200 && preorderStocks.isEmpty) {
            noResult = true;
          }
          stocks = preorderStocks;
        } else {
          //in-store
          for (var stock in preorderStocks) {
            if (stock.quantity > 0) {
              instoreStocks.add(stock);
            }
          }
          filteredStocks = instoreStocks;
          if (stockOrderPageResponse.status == 200 && instoreStocks.isEmpty) {
            noResult = true;
          }
          stocks = instoreStocks;
        }
        selectedStocks = stocks.map((stock) => stock.copyWith(quantity: 0)).toList();
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Addding Order',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: const Row(
                children: [
                  BakingUpSearchBar(hintText: 'Search Bakery Stock'),
                  SizedBox(width: 12),
                  BakingUpFilterTwoButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  return AddEditOrderStockDetails(
                    stocks: stocks,
                    index: index,
                    isPreOrder: widget.isPreOrder,
                    selectedStockList: selectedStocks,
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                  title: 'Save',
                  color: lightGreenColor,
                  onClick: () {
                    filteredSelectedStocks = selectedStocks.where((stock) => stock.quantity > 0).toList();
                     Navigator.pop(context, filteredSelectedStocks);
                  },
                )
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

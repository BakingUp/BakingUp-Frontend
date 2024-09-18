import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/stock/stock_list.dart';
import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final int _currentDrawerIndex = 9;
  bool isLoading = false;
  bool isError = false;
  List<StockItemData> stocks = [];
  List<StockItemData> filteredStocks = [];
  final TextEditingController _searchStockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStockList();
  }

  Future<void> _fetchStockList() async {
    setState(() {
      isLoading = true;
      isError = false;
      _searchStockController.clear();
    });

    try {
      final response = await NetworkService.instance
          .get('/api/stock/getAllStocks?user_id=1');

      final stockResponse = StockListResponse.fromJson(response);
      final data = stockResponse.data;
      setState(() {
        stocks = data.stocks;
        filteredStocks = stocks;
      });
    } catch (e) {
      isError = true;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterStocks(String query) {
    setState(() {
      if (query == "") {
        filteredStocks = stocks;
      } else {
        filteredStocks = stocks
            .where((stock) =>
                stock.stockName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Bakery Stock",
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
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: BakingUpCircularAddButton(),
          )
        ],
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: Row(
                  children: [
                    BakingUpSearchBar(
                      hintText: 'Search Bakery Stock',
                      controller: _searchStockController,
                      onChanged: _filterStocks,
                    ),
                    const SizedBox(width: 12),
                    const BakingUpFilterTwoButton()
                  ],
                ),
              ),
              StockList(stockList: filteredStocks, isLoading: isLoading)
            ],
          )),
    );
  }
}

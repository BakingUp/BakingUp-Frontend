import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
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
  final List<String> stockFilterList = [
    'Stock Name',
    'Quantity',
    'LST',
    'Selling Price',
    'LST Status'
  ];
  String selectedStockFiltering = "Stock Name";
  String selectedStockSorting = "Ascending Order";
  FocusNode stockSearchFocusNode = FocusNode();
  bool noResult = false;

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
      noResult = false;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/stock/getAllStocks?user_id=1');

      final stockResponse = StockListResponse.fromJson(response);
      final data = stockResponse.data;
      setState(() {
        stocks = data.stocks;
        filteredStocks = stocks;
        if (stockResponse.status == 200 && stocks.isEmpty) {
          noResult = true;
        }
      });
    } catch (e) {
      isError = true;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _searchStocks(String query) {
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

  void _filterStocks(
      String selectingStockFiltering, String selectingStockSorting) {
    setState(() {
      selectedStockFiltering = selectingStockFiltering;
      selectedStockSorting = selectingStockSorting;
    });
    if (selectedStockSorting == "Ascending Order") {
      switch (selectingStockFiltering) {
        case "Stock Name":
          filteredStocks.sort((a, b) => a.stockName.compareTo(b.stockName));
          break;
        case "Quantity":
          filteredStocks.sort((a, b) => a.quantity.compareTo(b.quantity));
          break;
        case "LST":
          filteredStocks.sort((a, b) => a.lst.compareTo(b.lst));
          break;
        case "Selling Price":
          filteredStocks
              .sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
          break;
        case "LST Status":
          filteredStocks.sort((a, b) => convertLSTStatus(a.lstStatus)
              .compareTo(convertLSTStatus(b.lstStatus)));
          break;
        default:
          filteredStocks.sort((a, b) => a.stockName.compareTo(b.stockName));
      }
    } else {
      switch (selectingStockFiltering) {
        case "Stock Name":
          filteredStocks.sort((a, b) => b.stockName.compareTo(a.stockName));
          break;
        case "Quantity":
          filteredStocks.sort((a, b) => b.quantity.compareTo(a.quantity));
          break;
        case "LST":
          filteredStocks.sort((a, b) => b.lst.compareTo(a.lst));
          break;
        case "Selling Price":
          filteredStocks
              .sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
          break;
        case "LST Status":
          filteredStocks.sort((a, b) => convertLSTStatus(b.lstStatus)
              .compareTo(convertLSTStatus(a.lstStatus)));
          break;
        default:
          filteredStocks.sort((a, b) => b.stockName.compareTo(a.stockName));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        stockSearchFocusNode.unfocus();
      },
      child: Scaffold(
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
                        onChanged: _searchStocks,
                        focusNode: stockSearchFocusNode,
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              backgroundColor: backgroundColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return BakingUpFilterModalBottom(
                                  optionsOne: stockFilterList,
                                  optionOneName: "Filter by",
                                  defaultFilteringValue: selectedStockFiltering,
                                  defaultSortingValue: selectedStockSorting,
                                  filterFunction: _filterStocks,
                                );
                              },
                            );
                          },
                          child: const BakingUpFilterTwoButton())
                    ],
                  ),
                ),
                if (!noResult && filteredStocks.isNotEmpty)
                  StockList(
                    stockList: filteredStocks,
                    isLoading: isLoading,
                  )
                else if (!noResult && !isLoading && filteredStocks.isEmpty)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: const BakingUpNoResult(
                      message: "No results found",
                    ),
                  )
                else if (noResult)
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: const BakingUpNoResult(
                      message: "You currently have no stocks",
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}

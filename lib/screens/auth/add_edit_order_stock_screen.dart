import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock_order_page.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/add_edit_order/add_edit_order_stock_details.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:flutter/material.dart';

class AddEditOrderStockScreen extends StatefulWidget {
  final bool isPreOrder;
  final List<StockOrderItemData> oldSelectedStocks;
  const AddEditOrderStockScreen(
      {super.key, required this.isPreOrder, required this.oldSelectedStocks});

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

  final List<String> stockFilterList = [
    'Recipe Name',
    'Quantity',
    'EXP Date',
  ];
  String selectedStockFiltering = "Recipe Name";
  String selectedStockSorting = "Ascending Order";

  List<StockOrderItemData> filteredSelectedStocks = [];
  final TextEditingController _searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

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
      filteredStocks = [];
    });

    try {
      final response = await NetworkService.instance.get(
          '/api/stock/getAllStocksForOrder/?user_id=$userID');

      final stockOrderPageResponse = StockOrderPageResponse.fromJson(response);
      final data = stockOrderPageResponse.data;

      setState(() {
        preorderStocks = data.stocks;

        if (widget.isPreOrder) {
          filteredStocks = preorderStocks;
          stocks = preorderStocks;
          noResult =
              stockOrderPageResponse.status == 200 && preorderStocks.isEmpty;
        } else {
          instoreStocks =
              data.stocks.where((stock) => stock.quantity > 0).toList();
          filteredStocks = instoreStocks;
          stocks = instoreStocks;
          noResult =
              stockOrderPageResponse.status == 200 && instoreStocks.isEmpty;
        }
        for (var stock in stocks) {
          selectedStocks.add(stock.copyWith(quantity: 0));
          for (var oldStock in widget.oldSelectedStocks) {
            if (stock.recipeID == oldStock.recipeID) {
              selectedStocks.add(stock.copyWith(quantity: oldStock.quantity));
              break;
            }
          }
        }
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

  void _searchStocks(String query) {
    setState(() {
      filteredStocks = stocks
          .where((stock) =>
              stock.recipeName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _filterStock(String selectingStockFiltering, String selectingStockSorting) {
    setState(() {
      selectedStockFiltering = selectingStockFiltering;
      selectedStockSorting = selectingStockSorting;
    });
    if (selectedStockSorting == "Ascending Order") {
      switch (selectedStockFiltering) {
        case "Recipe Name":
          filteredStocks.sort((a, b) => a.recipeName.compareTo(b.recipeName));
          break;
        case "Quantity":
          filteredStocks.sort((a, b) => a.quantity.compareTo(b.quantity));
          break;
        case "EXP Date":
          filteredStocks.sort((a, b) => a.sellByDate.compareTo(b.sellByDate));
          break;
      }
    } else {
      switch (selectedStockFiltering) {
        case "Recipe Name":
          filteredStocks.sort((a, b) => b.recipeName.compareTo(a.recipeName));
          break;
        case "Quantity":
          filteredStocks.sort((a, b) => b.quantity.compareTo(a.quantity));
          break;
        case "EXP Date":
          filteredStocks.sort((a, b) => b.sellByDate.compareTo(a.sellByDate));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Row(
                children: [
                  BakingUpSearchBar(
                    hintText: 'Search Bakery Stock',
                    controller: _searchController,
                    onChanged: _searchStocks,
                    focusNode: searchFocusNode,
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                      onTap: () {
                        searchFocusNode.unfocus();
                        showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: backgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return BakingUpFilterModalBottom(
                                      optionsOne: stockFilterList,
                                      optionOneName: "Filter by",
                                      defaultFilteringValue:
                                          selectedStockFiltering,
                                      defaultSortingValue: selectedStockSorting,
                                      filterFunction: _filterStock,
                                    );
                            });
                      },
                      child: const BakingUpFilterTwoButton(),
                    )
                ],
              ),
            ),
            if (noResult)
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: const BakingUpNoResult(
                  message: "You currently have no order",
                ),
              )
            else if (!noResult && filteredStocks.isEmpty && !isLoading)
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: const BakingUpNoResult(
                  message: "No results found",
                ),
              )
            else if (!noResult && filteredStocks.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: filteredStocks.length,
                  itemBuilder: (context, index) {
                    return AddEditOrderStockDetails(
                      stocks: filteredStocks,
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
                      filteredSelectedStocks = selectedStocks
                          .where((stock) => stock.quantity > 0)
                          .toList();
                      Navigator.pop(context, filteredSelectedStocks);
                    },
                    isDisabled: false,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }
}

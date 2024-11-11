import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/models/warehouse.dart';
import 'package:bakingup_frontend/screens/add_stock_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_error.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/stock/stock_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final int _currentDrawerIndex = 4;
  bool isLoading = false;
  bool isError = false;
  List<StockItemData> stocks = [];
  List<StockItemData> filteredStocks = [];
  final TextEditingController _searchStockController = TextEditingController();
  int recipeLength = -1;
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
  final userId = FirebaseAuth.instance.currentUser!.uid;

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
          .get('/api/stock/getAllStocks?user_id=$userId');

      final recipeResponse = await NetworkService.instance
          .get('/api/recipe/getAllRecipes?user_id=$userId');

      final stockResponse = StockListResponse.fromJson(response);
      final allRecipeResponse = RecipeListResponse.fromJson(recipeResponse);

      final data = stockResponse.data;
      final allRecipeLength = allRecipeResponse.data.recipeList.length;

      setState(() {
        stocks = data.stocks;
        filteredStocks = stocks;
        recipeLength = allRecipeLength;
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
            centerTitle: true,
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
            actions: [
              recipeLength != stocks.length
                  ? Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: BakingUpCircularAddButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddStockScreen(),
                            ),
                          ).then((value) {
                            _fetchStockList();
                          });
                        },
                      ),
                    )
                  : Container()
            ],
          ),
          bottomNavigationBar: const BottomNavbar(),
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
                                    defaultFilteringValue:
                                        selectedStockFiltering,
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
                  if (isError)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: const BakingUpError(),
                    )
                  else if (noResult)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: const BakingUpNoResult(
                        message: "You currently have no stocks",
                      ),
                    )
                  else if (!noResult &&
                      stocks.isNotEmpty &&
                      filteredStocks.isEmpty)
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: const BakingUpNoResult(
                        message: "No results found",
                      ),
                    )
                  else if (!noResult)
                    StockList(
                      stockList: filteredStocks,
                      isLoading: isLoading,
                      fetchStocks: _fetchStockList,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  bottomLeft: Radius.circular(13))),
                          child: Tooltip(
                            verticalOffset: -20,
                            showDuration: const Duration(seconds: 5),
                            margin: const EdgeInsets.only(right: 40),
                            triggerMode: TooltipTriggerMode.tap,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            richMessage: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Container(
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: const Text(
                                      "These colors on each stock refer to its low stock threshold.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/icons/info_icon.png',
                              width: 20,
                              height: 20,
                            ),
                          ))
                    ],
                  )
                ],
              )),
        ));
  }
}

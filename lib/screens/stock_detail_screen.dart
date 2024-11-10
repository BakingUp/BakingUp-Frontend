// Importing libraries
import 'package:bakingup_frontend/screens/add_edit_stock_information_screen.dart';
import 'package:flutter/material.dart';
// Importing files
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_back_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_detail_image.dart';
import 'package:bakingup_frontend/models/stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_back_button_container.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_container.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_list.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_lst.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_notify_me.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_quantity.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_selling_price.dart';
import 'package:bakingup_frontend/widgets/stock_detail/stock_detail_stock_name.dart';
import 'package:intl/intl.dart';

class StockDetailScreen extends StatefulWidget {
  final String? recipeId;
  const StockDetailScreen({super.key, this.recipeId});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  List<String> stockUrl = [];
  String stockName = '';
  int quantity = 0;
  int stockLessThan = 0;
  int lst = 0;
  double price = 0.0;
  List<StockDetail> stockDetails = [];
  bool isLoading = true;
  bool isError = false;
  final List<String> stockFilterList = [
    'Quantity',
    'Sell-By Date',
  ];
  String selectedStockFiltering = "Quantity";
  String selectedStockSorting = "Ascending Order";
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

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
        '/api/stock/getStockDetail?recipe_id=${widget.recipeId}',
      );
      final stockDetailResponse = StockDetailResponse.fromJson(response);
      final data = stockDetailResponse.data;
      setState(() {
        stockUrl = data.stockUrl ?? [];
        stockName = data.stockName;
        quantity = data.quantity;
        lst = data.lst;
        price = data.sellingPrice;
        stockLessThan = data.stockLessThan;
        stockDetails = data.stockDetails ?? [];
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

  void _filterStock(
      String selectingStockFiltering, String selectingStockSorting) {
    setState(() {
      selectedStockFiltering = selectingStockFiltering;
      selectedStockSorting = selectingStockSorting;
    });
    if (selectedStockSorting == "Ascending Order") {
      switch (selectedStockFiltering) {
        case "Quantity":
          stockDetails.sort((a, b) => a.quantity.compareTo(b.quantity));
          break;
        case "Sell-By Date":
          stockDetails.sort((a, b) {
            DateTime dateA = dateFormat.parse(a.sellByDate);
            DateTime dateB = dateFormat.parse(b.sellByDate);
            return dateA.compareTo(dateB);
          });
          break;
        default:
          stockDetails.sort((a, b) => a.quantity.compareTo(b.quantity));
      }
    } else {
      switch (selectedStockFiltering) {
        case "Quantity":
          stockDetails.sort((a, b) => b.quantity.compareTo(a.quantity));
          break;
        case "Sell-By Date":
          stockDetails.sort((a, b) {
            DateTime dateA = dateFormat.parse(a.sellByDate);
            DateTime dateB = dateFormat.parse(b.sellByDate);
            return dateB.compareTo(dateA);
          });
          break;
        default:
          stockDetails.sort((a, b) => b.quantity.compareTo(a.quantity));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BakingUpDetailImage(
            imageUrl: stockUrl,
            isLoading: isLoading,
            noBaseURL: false,
            isScaled: false,
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
              child: Column(children: [
                if (stockDetails.isEmpty && !isLoading) ...[
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BakingUpNoResult(
                            message:
                                "This stock currently has no stock batchs."),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  )
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tooltip(
                          verticalOffset: -20,
                          showDuration: const Duration(seconds: 5),
                          margin: const EdgeInsets.only(right: 40, top: 45),
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
                                    "These color on each stock refer to its low stock threshold.",
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
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        BakingUpFilterButton(
                          optionsOne: stockFilterList,
                          optionOneName: "Filter by",
                          defaultFilteringValue: selectedStockFiltering,
                          defaultSortingValue: selectedStockSorting,
                          filterFunction: _filterStock,
                        ),
                      ],
                    ),
                  ),
                  StockDetailList(
                    stockDetails: stockDetails,
                    isLoading: isLoading,
                    onDelete: (index) {
                      setState(() {
                        stockDetails.removeAt(index);
                      });
                    },
                  ),
                ]
              ]),
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
                          recipeId: widget.recipeId ?? '',
                          fetchStockDetails: _fetchStockDetails,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                        ),
                      ],
                    ),
                    BakingUpCircularAddButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditStockInformationScreen(
                              recipeId: widget.recipeId,
                            ),
                          ),
                        ).then((_) {
                          _fetchStockDetails();
                        });
                      },
                    ),
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

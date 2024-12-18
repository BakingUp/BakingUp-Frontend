// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_back_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_button.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_stock_detail_list.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_container.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_ingredient_name.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_notify_me.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_quantity.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_stock.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_back_button_container.dart';
import 'package:bakingup_frontend/models/ingredient_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_detail_image.dart';
import 'package:bakingup_frontend/screens/add_ingredient_stock_screen.dart';
import 'package:intl/intl.dart';

class IngredientDetailScreen extends StatefulWidget {
  final String? ingredientId;
  const IngredientDetailScreen({super.key, this.ingredientId});

  @override
  State<IngredientDetailScreen> createState() => _IngredientDetailScreenState();
}

class _IngredientDetailScreenState extends State<IngredientDetailScreen> {
  List<String> ingredientUrl = [];
  String ingredientName = '';
  double quantity = 0.0;
  String unit = '';
  double ingredientLessThan = 0.0;
  bool isLoading = true;
  bool isError = true;
  List<IngredientStock> ingredientStocks = [];
  final List<String> ingredientFilterList = ['Quantity', 'Expiration Date'];
  String selectedIngredientFiltering = "Quantity";
  String selectedIngredientSorting = "Ascending Order";
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _fetchIngredientDetails();
  }

  Future<void> _fetchIngredientDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/ingredient/getIngredientDetail?ingredient_id=${widget.ingredientId}',
      );
      final ingredientDetailResponse =
          IngredientDetailResponse.fromJson(response);
      final data = ingredientDetailResponse.data;
      setState(() {
        ingredientUrl = data.ingredientUrl ?? [];
        ingredientName = data.ingredientName;
        quantity = double.parse(data.ingredientQuantity.split(' ').first);
        unit = data.ingredientQuantity.split(' ').last;
        ingredientLessThan = data.ingredientLessThan.toDouble();
        ingredientStocks = data.stocks ?? [];
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

  void _filterIngredient(
      String selectingIngredientFiltering, String selectingIngredientSorting) {
    setState(() {
      selectedIngredientFiltering = selectingIngredientFiltering;
      selectedIngredientSorting = selectingIngredientSorting;
    });
    if (selectedIngredientSorting == "Ascending Order") {
      switch (selectedIngredientFiltering) {
        case "Quantity":
          ingredientStocks.sort((a, b) => a.quantity.compareTo(b.quantity));
          break;
        case "Expiration Date":
          ingredientStocks.sort((a, b) {
            DateTime dateA = dateFormat.parse(a.expirationDate);
            DateTime dateB = dateFormat.parse(b.expirationDate);
            return dateA.compareTo(dateB);
          });
          break;
        default:
          ingredientStocks.sort((a, b) => a.quantity.compareTo(b.quantity));
      }
    } else {
      switch (selectedIngredientFiltering) {
        case "Quantity":
          ingredientStocks.sort((a, b) => b.quantity.compareTo(a.quantity));
          break;
        case "Expiration Date":
          ingredientStocks.sort((a, b) {
            DateTime dateA = dateFormat.parse(a.expirationDate);
            DateTime dateB = dateFormat.parse(b.expirationDate);
            return dateB.compareTo(dateA);
          });
          break;
        default:
          ingredientStocks.sort((a, b) => b.quantity.compareTo(a.quantity));
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
            imageUrl: ingredientUrl,
            isLoading: isLoading,
            isScaled: false,
          ),
          const IngredientDetailBackButtonContainer(
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
                  if (ingredientStocks.isNotEmpty) ...[
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
                                      "These color icons in this page refer to your expiring threshold.",
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
                            optionsOne: ingredientFilterList,
                            optionOneName: "Filter by",
                            defaultFilteringValue: selectedIngredientFiltering,
                            defaultSortingValue: selectedIngredientSorting,
                            filterFunction: _filterIngredient,
                          ),
                        ],
                      ),
                    ),
                  ],
                  IngredientStockDetailList(
                    ingredientStocks: ingredientStocks,
                    ingredientId: widget.ingredientId ?? '',
                    isLoading: isLoading,
                    fetchIngredientList: _fetchIngredientDetails,
                  ),
                ],
              ),
            ),
          ),
          IngredientDetailContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        IngredientDetailIngredientName(
                          ingredientName: ingredientName,
                          ingredientId: widget.ingredientId ?? '',
                          fetchIngredientList: _fetchIngredientDetails,
                          isLoading: isLoading,
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
                            builder: (context) => AddIngredientStockScreen(
                              ingredientId: widget.ingredientId,
                            ),
                          ),
                        ).then((_) {
                          _fetchIngredientDetails();
                        });
                      },
                    ),
                  ],
                ),
                IngredientDetailQuantity(
                  quantity: quantity,
                  unit: unit,
                  isLoading: isLoading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IngredientDetailStock(
                      ingredientStocksNumber: ingredientStocks.length,
                      isLoading: isLoading,
                    ),
                    IngredientDetailNotifyMe(
                      ingredientLessThan: ingredientLessThan,
                      unit: unit,
                      isLoading: isLoading,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

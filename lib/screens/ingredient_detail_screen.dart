// Importing libraries
import 'package:bakingup_frontend/models/ingredient_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
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
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_image.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_image_container.dart';

class IngredientDetailScreen extends StatefulWidget {
  const IngredientDetailScreen({super.key});

  @override
  State<IngredientDetailScreen> createState() => _IngredientDetailScreenState();
}

class _IngredientDetailScreenState extends State<IngredientDetailScreen> {
  String ingredientId = '1';
  String ingredientUrl =
      '';
  String ingredientName = '';
  double quantity = 0.0;
  String unit = '';
  double ingredientLessThan = 0.0;
  bool isLoading = true;
  bool isError = true;
  List<IngredientStock> ingredientStocks = [];

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
        '/api/ingredient/$ingredientId',
      );
      final ingredientDetailResponse =
          IngredientDetailResponse.fromJson(response);
      final data = ingredientDetailResponse.data;
      setState(() {
        ingredientUrl = data.ingredientUrl.first;
        ingredientName = data.ingredientName;
        quantity = double.parse(data.ingredientQuantity.split(' ').first);
        unit = data.ingredientQuantity.split(' ').last;
        ingredientLessThan = data.ingredientLessThan.toDouble();
        ingredientStocks = data.stocks;
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
          IngredientDetailImageContainer(
            child: IngredientDetailImage(
              ingredientUrl: ingredientUrl,
              isLoading: isLoading,
            ),
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
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BakingUpFilterButton(),
                      ],
                    ),
                  ),
                  IngredientStockDetailList(
                    ingredientStocks: ingredientStocks,
                    isLoading: isLoading,
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

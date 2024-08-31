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
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_image.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/ingredient_detail_image_container.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';

class IngredientDetailScreen extends StatefulWidget {
  const IngredientDetailScreen({super.key});

  @override
  State<IngredientDetailScreen> createState() => _IngredientDetailScreenState();
}

class _IngredientDetailScreenState extends State<IngredientDetailScreen> {
  String ingredientUrl = 'https://i.imgur.com/RLsjqFm.png';
  String ingredientName = 'All-purpose flour';
  double quantity = 1.4;
  String unit = 'kg';
  double ingredientLessThan = 3;
  bool isLoading = false;
  List<IngredientStock> ingredientStocks = [
    IngredientStock(
        stockId: '1',
        stockUrl: 'https://i.imgur.com/RLsjqFm.png',
        price: '37/kg',
        quantity: '1 kg',
        expirationDate: '29/06/2024',
        expirationStatus: ExpirationStatus.red),
    IngredientStock(
        stockId: '2',
        stockUrl: 'https://i.imgur.com/RLsjqFm.png',
        price: '37/kg',
        quantity: '1 kg',
        expirationDate: '29/06/2024',
        expirationStatus: ExpirationStatus.green),
    IngredientStock(
        stockId: '2',
        stockUrl: 'https://i.imgur.com/RLsjqFm.png',
        price: '37/kg',
        quantity: '1 kg',
        expirationDate: '29/06/2024',
        expirationStatus: ExpirationStatus.yellow),
    IngredientStock(
        stockId: '3',
        stockUrl: 'https://i.imgur.com/RLsjqFm.png',
        price: '37/kg',
        quantity: '1 kg',
        expirationDate: '29/06/2024',
        expirationStatus: ExpirationStatus.black),
  ];

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

// Temporary class to simulate the data
class IngredientStock {
  final String stockId;
  final String stockUrl;
  final String price;
  final String quantity;
  final String expirationDate;
  final ExpirationStatus expirationStatus;

  IngredientStock({
    required this.stockId,
    required this.stockUrl,
    required this.price,
    required this.quantity,
    required this.expirationDate,
    required this.expirationStatus,
  });
}

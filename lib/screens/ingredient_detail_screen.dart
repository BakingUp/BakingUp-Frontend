// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/components/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/components/baking_up_circular_back_button.dart';
import 'package:bakingup_frontend/components/baking_up_filter_button.dart';
import 'package:bakingup_frontend/components/ingredient_detail/ingredient_detail_back_button_container.dart';
import 'package:bakingup_frontend/components/ingredient_detail/ingredient_detail_image.dart';
import 'package:bakingup_frontend/components/ingredient_detail/ingredient_detail_image_container.dart';
import 'package:bakingup_frontend/components/ingredient_detail/ingredient_stock_detail.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/utilities/regex.dart';

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
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: ingredientStocks.length,
                      itemBuilder: (context, index) {
                        return IngredientStockDetail(
                          ingredientStocks: ingredientStocks,
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width / 1.5,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 20,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  ingredientName,
                                  style: TextStyle(
                                    color: blackColor,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 10.0)),
                                Image.asset('assets/icons/edit.png'),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 8.0)),
                          ],
                        ),
                        const BakingUpCircularAddButton(),
                      ],
                    ),
                    Text(
                      'Quantity: ${quantity.toString().replaceAll(removeTrailingZeros, '')} $unit',
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${ingredientStocks.length} ${ingredientStocks.length > 1 ? "stocks" : "stock"}',
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Notify me : < ${ingredientLessThan.toString().replaceAll(removeTrailingZeros, '')} $unit',
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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

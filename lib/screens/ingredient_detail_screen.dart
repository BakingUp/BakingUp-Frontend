import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:flutter/material.dart';

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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              ingredientUrl,
              width: MediaQuery.of(context)
                  .size
                  .width, // Make the image take all the width
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 0,
            child: Row(
              children: [
                FloatingActionButton(
                  backgroundColor: beigeColor,
                  onPressed: () {},
                  elevation: 5,
                  shape: const CircleBorder(),
                  mini: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/icons/filter.png'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: ingredientStocks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: ingredientStocks[index].expirationStatus ==
                                    ExpirationStatus.black
                                ? greyColor
                                : beigeColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Image.network(
                                      ingredientStocks[index].stockUrl,
                                      width: 80,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 12.0)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price: ${ingredientStocks[index].price}',
                                        style: TextStyle(
                                          color: blackColor,
                                          fontFamily: 'Inter',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        'Quantity: ${ingredientStocks[index].quantity}',
                                        style: TextStyle(
                                          color: blackColor,
                                          fontFamily: 'Inter',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        'Expiration Date: ${ingredientStocks[index].expirationDate}',
                                        style: TextStyle(
                                          color: ingredientStocks[index]
                                                      .expirationStatus ==
                                                  ExpirationStatus.black
                                              ? redColor
                                              : blackColor,
                                          fontFamily: 'Inter',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ingredientStocks[index]
                                                  .expirationStatus ==
                                              ExpirationStatus.black
                                          ? blackColor
                                          : ingredientStocks[index]
                                                      .expirationStatus ==
                                                  ExpirationStatus.red
                                              ? redColor
                                              : ingredientStocks[index]
                                                          .expirationStatus ==
                                                      ExpirationStatus.yellow
                                                  ? yellowColor
                                                  : greenColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 20.0)),
                                  Image.asset(
                                    'assets/icons/edit.png',
                                    scale: 0.7,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 8.0)),
                                ],
                              )
                            ],
                          ),
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
                        FloatingActionButton(
                          backgroundColor: beigeColor,
                          onPressed: () {},
                          elevation: 5,
                          shape: const CircleBorder(),
                          mini: true,
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: blackColor,
                          ),
                        ),
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

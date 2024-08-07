import 'package:bakingup_frontend/widgets/ingredient_detail/expiration_status_indicator.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/screens/ingredient_detail_screen.dart';
import 'package:flutter/material.dart';

class IngredientStockDetail extends StatelessWidget {
  final List<IngredientStock> ingredientStocks;
  final int index;

  const IngredientStockDetail(
      {super.key, required this.ingredientStocks, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color:
            ingredientStocks[index].expirationStatus == ExpirationStatus.black
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
              const Padding(padding: EdgeInsets.only(right: 12.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: ingredientStocks[index].expirationStatus ==
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
              ExpirationStatusIndicator(
                  status: ingredientStocks[index].expirationStatus),
              const Padding(padding: EdgeInsets.only(right: 20.0)),
              Image.asset(
                'assets/icons/edit.png',
                scale: 0.7,
              ),
              const Padding(padding: EdgeInsets.only(right: 8.0)),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:bakingup_frontend/models/stock_recipe_detail.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class AddEditStockInformationIngredient extends StatelessWidget {
  final StockRecipeIngredientData stockIngredient;
  final int quantity;
  final int servings;
  const AddEditStockInformationIngredient({
    super.key,
    required this.stockIngredient,
    required this.quantity,
    required this.servings,
  });

  double calculateIngredientQuantity() {
    if (quantity == -1) {
      return stockIngredient.ingredientQuantity;
    }

    return stockIngredient.ingredientQuantity * quantity / servings;
  }

  bool isQuantityMoreThanStock() {
    return calculateIngredientQuantity() > stockIngredient.stockQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 15),
      width: MediaQuery.of(context).size.width - 82,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  "${dotenv.env['API_BASE_URL']}/${stockIngredient.ingredientUrl}",
                  width: 80,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/icons/no-image.jpg',
                      width: 80,
                      height: 50,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 12.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        stockIngredient.ingredientName,
                        style: TextStyle(
                          color: isQuantityMoreThanStock()
                              ? errorRedColor
                              : blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Quantity: ${NumberFormat('#,##0.00').format(stockIngredient.stockQuantity).replaceAll(removeTrailingZeros, '')} ${stockIngredient.unit.toLowerCase()}',
                    style: TextStyle(
                      color: isQuantityMoreThanStock()
                          ? errorRedColor
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
              Text(
                "${NumberFormat('#,##0.00').format(calculateIngredientQuantity()).replaceAll(removeTrailingZeros, '')} ${stockIngredient.unit.toLowerCase()}",
                style: TextStyle(
                  color: isQuantityMoreThanStock() ? errorRedColor : blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

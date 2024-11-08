import 'package:bakingup_frontend/models/ingredient_detail.dart';
import 'package:bakingup_frontend/screens/edit_ingredient_stock_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_stock_detail_screen.dart';
import 'package:bakingup_frontend/widgets/ingredient_detail/expiration_status_indicator.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shimmer/shimmer.dart';

class IngredientStockDetail extends StatelessWidget {
  final List<IngredientStock> ingredientStocks;
  final String ingredientId;
  final int index;
  final bool isLoading;
  final VoidCallback fetchIngredientList;

  const IngredientStockDetail({
    super.key,
    required this.ingredientStocks,
    required this.ingredientId,
    required this.index,
    required this.isLoading,
    required this.fetchIngredientList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IngredientStockDetailScreen(
              ingredientStockId: ingredientStocks[index].stockId,
            ),
          ),
        );
      },
      child: Container(
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
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (ingredientStocks[index].stockUrl.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.network(
                          '${dotenv.env['API_BASE_URL']}/${ingredientStocks[index].stockUrl}',
                          width: 80,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ] else ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          'assets/icons/no-image.jpg',
                          width: 80,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
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
              ],
            ),
            Row(
              children: [
                ExpirationStatusIndicator(
                    status: ingredientStocks[index].expirationStatus),
                const Padding(padding: EdgeInsets.only(right: 20.0)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditIngredientStockScreen(
                          ingredientId: ingredientId,
                          ingredientStockId: ingredientStocks[index].stockId,
                        ),
                      ),
                    ).then((value) => fetchIngredientList());
                  },
                  child: Image.asset(
                    'assets/icons/edit.png',
                    scale: 0.7,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 8.0)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

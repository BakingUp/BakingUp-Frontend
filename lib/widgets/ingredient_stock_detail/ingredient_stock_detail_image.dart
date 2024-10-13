import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IngredientStockDetailImage extends StatelessWidget {
  final bool isLoading;
  final String ingredientStockDetailUrl;
  const IngredientStockDetailImage({
    super.key,
    required this.isLoading,
    required this.ingredientStockDetailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: !isLoading
          ? ingredientStockDetailUrl.isEmpty
              ? Image.asset(
                  'assets/icons/no-image.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  '${dotenv.env['API_BASE_URL']}/$ingredientStockDetailUrl',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
          : Container(),
    );
  }
}

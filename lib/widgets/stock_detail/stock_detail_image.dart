import 'package:flutter/widgets.dart';

class StockDetailImage extends StatelessWidget {
  final String stockUrl;

  const StockDetailImage({super.key, required this.stockUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      stockUrl,
      width: MediaQuery.of(context)
          .size
          .width,
      fit: BoxFit.cover,
    );
  }
}
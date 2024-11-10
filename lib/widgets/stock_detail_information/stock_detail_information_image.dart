import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StockDetailInformationImage extends StatelessWidget {
  final bool isLoading;
  final String stockUrl;
  const StockDetailInformationImage({
    super.key,
    required this.isLoading,
    required this.stockUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: !isLoading
          ? Image.network(
              '${dotenv.env['API_BASE_URL']}/$stockUrl',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }
}

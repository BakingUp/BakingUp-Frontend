import 'package:flutter/material.dart';

class StockDetailInformationImage extends StatelessWidget {
  final bool isLoading;
  const StockDetailInformationImage({
    super.key,
    required this.isLoading,
  });
  final stockUrl =
      "https://images.immediate.co.uk/production/volatile/sites/30/2021/09/butter-cookies-262c4fd.jpg";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: !isLoading
          ? Image.network(
              stockUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }
}

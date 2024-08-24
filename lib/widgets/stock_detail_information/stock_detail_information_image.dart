import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class StockDetailInformationImage extends StatelessWidget {
  const StockDetailInformationImage({super.key});
  final stockUrl =
      "https://images.immediate.co.uk/production/volatile/sites/30/2021/09/butter-cookies-262c4fd.jpg";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor,
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: Image.network(
        stockUrl,
        width: MediaQuery.of(context)
            .size
            .width, // Make the image take all the width
        fit: BoxFit.cover,
      ),
    );
  }
}

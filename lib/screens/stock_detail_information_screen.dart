// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_image.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_title.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_note.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_container.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_bakery_quantity.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_bakery_recipe.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_bakery_sell_by_date.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailInformationScreen extends StatelessWidget {
  const StockDetailInformationScreen({super.key});

  final String note = "For order #3";
  final String createdAt = "03/03/2024";
  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Butter Cookie",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            );
          },
        ),
      ),
      body: StockDetailInformationContainer(
        children: [
          const StockDetailInformationTitle(title: "Bakery Stock Information"),
          Stack(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  margin: const EdgeInsets.all(12.0),
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  StockDetailInformationImage(isLoading: isLoading),
                  const SizedBox(height: 16),
                  StockDetailInformationBakeryRecipe(isLoading: isLoading),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      StockDetailInformationBakeryQuantity(isLoading: isLoading)
                    ],
                  ),
                  const SizedBox(height: 16),
                  StockDetailInformationBakerySellByDate(isLoading: isLoading),
                  const SizedBox(height: 50),
                  const StockDetailInformationTitle(title: "Note:"),
                  const SizedBox(height: 16),
                  StockDetailInformationNote(
                    note: note,
                    createdAt: createdAt,
                    isLoading: isLoading,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

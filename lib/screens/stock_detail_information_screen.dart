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
import 'package:bakingup_frontend/models/stock_batch.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:shimmer/shimmer.dart';

class StockDetailInformationScreen extends StatefulWidget {
  final String? stockDetailId;
  const StockDetailInformationScreen({super.key, this.stockDetailId});

  @override
  State<StockDetailInformationScreen> createState() =>
      _StockDetailInformationScreenState();
}

class _StockDetailInformationScreenState
    extends State<StockDetailInformationScreen> {
  String recipeName = "";
  String recipeUrl = "";
  int quantity = 0;
  String sellByDate = "";
  String note = "";
  String noteCreatedAt = "";
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchStockBatch();
  }

  Future<void> _fetchStockBatch() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/stock/getStockBatch?stock_detail_id=${widget.stockDetailId}',
      );
      final stockBatchResponse = StockBatchResponse.fromJson(response);
      final data = stockBatchResponse.data;
      setState(() {
        recipeName = data.recipeName;
        recipeUrl = data.recipeUrl;
        quantity = data.quantity;
        sellByDate = data.sellByDate;
        note = data.note;
        noteCreatedAt = data.noteCreatedAt;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: StockDetailInformationContainer(
        children: [
          const StockDetailInformationTitle(title: "Bakery Stock Information"),
          Stack(
            children: [
              if (isLoading || recipeUrl.isNotEmpty) ...[
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
              ],
              Column(
                children: [
                  if (isLoading || recipeUrl.isNotEmpty) ...[
                    StockDetailInformationImage(
                      isLoading: isLoading,
                      stockUrl: recipeUrl,
                    ),
                  ],
                  const SizedBox(height: 16),
                  StockDetailInformationBakeryRecipe(
                    isLoading: isLoading,
                    recipeName: recipeName,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      StockDetailInformationBakeryQuantity(
                        isLoading: isLoading,
                        quantity: quantity,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  StockDetailInformationBakerySellByDate(isLoading: isLoading),
                  if (note.isNotEmpty || isLoading) ...[
                    const SizedBox(height: 50),
                    const StockDetailInformationTitle(title: "Note:"),
                    const SizedBox(height: 16),
                    StockDetailInformationNote(
                      note: note,
                      createdAt: noteCreatedAt,
                      isLoading: isLoading,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

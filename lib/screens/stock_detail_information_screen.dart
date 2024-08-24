// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_image.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_title.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_note.dart';
import 'package:bakingup_frontend/widgets/stock_detail_information/stock_detail_information_container.dart';

class StockDetailInformationScreen extends StatefulWidget {
  const StockDetailInformationScreen({super.key});

  @override
  State<StockDetailInformationScreen> createState() =>
      _StockDetailInformationScreenState();
}

class _StockDetailInformationScreenState
    extends State<StockDetailInformationScreen> {
  final String note = "For order #3";
  final String createdAt = "03/03/2024";

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
          const StockDetailInformationImage(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bakery Recipe',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Butter Cookie",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quantity:',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '10',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sell-By Date:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '29/03/2024',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          const StockDetailInformationTitle(title: "Note:"),
          const SizedBox(height: 16),
          StockDetailInformationNote(note: note, createdAt: createdAt),
        ],
      ),
    );
  }
}

// Temporary class to simulate the data
class StockInformationNote {
  final String stockNote;
  final String noteCreatedAt;

  StockInformationNote({
    required this.stockNote,
    required this.noteCreatedAt,
  });
}

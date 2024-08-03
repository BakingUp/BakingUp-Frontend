// Importing libraries
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_edit_button.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_image.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_detail.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_container.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_title.dart';

class IngredientStockDetailScreen extends StatefulWidget {
  const IngredientStockDetailScreen({super.key});

  @override
  State<IngredientStockDetailScreen> createState() =>
      _IngredientStockDetailScreenState();
}

class _IngredientStockDetailScreenState
    extends State<IngredientStockDetailScreen> {
  List<IngredientStockDetailNote> ingredientStockDetailNotes = [
    IngredientStockDetailNote(
      ingredientNote: "This ingredient is used for making bread.",
      noteCreatedAt: "03/03/2024",
    ),
    IngredientStockDetailNote(
      ingredientNote: "This ingredient is used for making cake.",
      noteCreatedAt: "06/03/2024",
    ),
    IngredientStockDetailNote(
      ingredientNote: "This ingredient is used for making cookies.",
      noteCreatedAt: "09/03/2024",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Ingredient",
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
      body: IngredientStockDetailContainer(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IngredientStockDetailTitle(title: "Ingredient Information"),
              const IngredientStockDetailEditButton(),
            ],
          ),
          const IngredientStockDetailImage(),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ingredient Name:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All purpose flour',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'แป้งอเนกประสงค์',
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
                'Brand:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'KITE',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
                    '1 kg.',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price:',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '36 ฿',
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
          const IngredientStockDetailTitle(title: "Additional Information"),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Supplier:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '-',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expiration Date:',
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
          const IngredientStockDetailTitle(title: "Note:"),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: ingredientStockDetailNotes.length,
            itemBuilder: (context, index) {
              return IngredientStockDetailNoteDetail(
                ingredientStockDetailNotes: ingredientStockDetailNotes,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}

// Temporary class to simulate the data
class IngredientStockDetailNote {
  final String ingredientNote;
  final String noteCreatedAt;

  IngredientStockDetailNote({
    required this.ingredientNote,
    required this.noteCreatedAt,
  });
}

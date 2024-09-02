// Importing libraries
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_brand.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_edit_button.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_expiration_date.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_image.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_ingredient_name.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_list.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_price.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_quantity.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_supplier.dart';
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_container.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_title.dart';
import 'package:shimmer/shimmer.dart';

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
  bool isLoading = false;

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IngredientStockDetailTitle(title: "Ingredient Information"),
              IngredientStockDetailEditButton(),
            ],
          ),
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
                  IngredientStockDetailImage(isLoading: isLoading),
                  const SizedBox(height: 16),
                  IngredientStockDetailIngredientName(isLoading: isLoading),
                  const SizedBox(height: 16),
                  IngredientStockDetailBrand(isLoading: isLoading),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IngredientStockDetailQuantity(isLoading: isLoading),
                      const SizedBox(width: 50),
                      IngredientStockDetailPrice(isLoading: isLoading),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const IngredientStockDetailTitle(
                      title: "Additional Information"),
                  const SizedBox(height: 16),
                  IngredientStockDetailSupplier(isLoading: isLoading),
                  const SizedBox(height: 16),
                  IngredientStockDetailExpirationDate(isLoading: isLoading),
                  const SizedBox(height: 50),
                  const IngredientStockDetailTitle(title: "Note:"),
                  const SizedBox(height: 16),
                  IngredientStockDetailNoteList(
                    ingredientStockDetailNotes: ingredientStockDetailNotes,
                    isLoading: isLoading,
                  )
                ],
              ),
            ],
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

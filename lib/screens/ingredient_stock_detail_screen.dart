// Importing libraries
import 'package:flutter/material.dart';

// Importing files
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_container.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_title.dart';
import 'package:bakingup_frontend/models/ingredient_stock_detail.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_brand.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_edit_button.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_expiration_date.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_image.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_ingredient_name.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_note_list.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_price.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_quantity.dart';
import 'package:bakingup_frontend/widgets/ingredient_stock_detail/ingredient_stock_detail_supplier.dart';
import 'package:shimmer/shimmer.dart';

class IngredientStockDetailScreen extends StatefulWidget {
  final String? ingredientStockId;
  const IngredientStockDetailScreen({super.key, this.ingredientStockId});

  @override
  State<IngredientStockDetailScreen> createState() =>
      _IngredientStockDetailScreenState();
}

class _IngredientStockDetailScreenState
    extends State<IngredientStockDetailScreen> {
  bool isLoading = true;
  bool isError = false;
  String ingredientStockDetailUrl = '';
  String ingredientEngName = '';
  String ingredientThaiName = '';
  String ingredientBrand = '';
  String ingredientQuantity = '';
  String ingredientPrice = '';
  String ingredientSupplier = '';
  String dayBeforeExpire = '';
  List<IngredientStockDetailNote> ingredientStockDetailNotes = [];

  @override
  void initState() {
    super.initState();
    _fetchIngredientStockDetails();
  }

  Future<void> _fetchIngredientStockDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance.get(
        '/api/ingredient/getIngredientStockDetail?ingredient_stock_id=${widget.ingredientStockId}',
      );
      final ingredientStockDetailResponse =
          IngredientStockDetailResponse.fromJson(response);
      final data = ingredientStockDetailResponse.data;
      setState(() {
        ingredientStockDetailUrl = data.ingredientStockUrl;
        ingredientEngName = data.ingredientEngName;
        ingredientThaiName = data.ingredientThaiName;
        ingredientBrand = data.ingredientBrand;
        ingredientQuantity = data.ingredientQuantity;
        ingredientPrice = data.ingredientPrice;
        ingredientSupplier = data.ingredientSupplier;
        dayBeforeExpire = data.dayBeforeExpire;
        ingredientStockDetailNotes = data.notes ?? [];
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
              onPressed: () {
                Navigator.pop(context);
              },
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
                  IngredientStockDetailImage(
                    isLoading: isLoading,
                    ingredientStockDetailUrl: ingredientStockDetailUrl,
                  ),
                  const SizedBox(height: 16),
                  IngredientStockDetailIngredientName(
                    isLoading: isLoading,
                    ingredientEngName: ingredientEngName,
                    ingredientThaiName: ingredientThaiName,
                  ),
                  const SizedBox(height: 16),
                  IngredientStockDetailBrand(
                    isLoading: isLoading,
                    ingredientBrand: ingredientBrand,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IngredientStockDetailQuantity(
                        isLoading: isLoading,
                        ingredientQuantity: ingredientQuantity,
                      ),
                      const SizedBox(width: 50),
                      IngredientStockDetailPrice(
                        isLoading: isLoading,
                        ingredientPrice: ingredientPrice,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const IngredientStockDetailTitle(
                      title: "Additional Information"),
                  const SizedBox(height: 16),
                  IngredientStockDetailSupplier(
                    isLoading: isLoading,
                    ingredientSupplier: ingredientSupplier,
                  ),
                  const SizedBox(height: 16),
                  IngredientStockDetailExpirationDate(
                    isLoading: isLoading,
                    dayBeforeExpire: dayBeforeExpire,
                  ),
                  const SizedBox(height: 50),
                  if (ingredientStockDetailNotes.isNotEmpty)
                    Column(
                      children: [
                        const IngredientStockDetailTitle(title: "Note:"),
                        const SizedBox(height: 16),
                        IngredientStockDetailNoteList(
                          ingredientStockDetailNotes:
                              ingredientStockDetailNotes,
                          isLoading: isLoading,
                        )
                      ],
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

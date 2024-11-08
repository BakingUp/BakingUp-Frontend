import 'package:json_annotation/json_annotation.dart';

part 'edit_ingredient_stock_detail.g.dart';

@JsonSerializable()
class EditIngredientStockDetailResponse {
  final int status;
  final String message;
  final EditIngredientStockData data;

  EditIngredientStockDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditIngredientStockDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$EditIngredientStockDetailResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$EditIngredientStockDetailResponseToJson(this);
}

@JsonSerializable()
class EditIngredientStockData {
  @JsonKey(name: 'ingredient_stock_id')
  final String ingredientStockId;
  final String brand;
  final String quantity;
  final String price;
  final String supplier;
  @JsonKey(name: 'expiration_date')
  final String expirationDate;

  EditIngredientStockData({
    required this.ingredientStockId,
    required this.brand,
    required this.quantity,
    required this.price,
    required this.supplier,
    required this.expirationDate,
  });

  factory EditIngredientStockData.fromJson(Map<String, dynamic> json) =>
      _$EditIngredientStockDataFromJson(json);
  Map<String, dynamic> toJson() => _$EditIngredientStockDataToJson(this);
}

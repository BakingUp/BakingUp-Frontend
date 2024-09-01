import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient_detail.g.dart';

@JsonSerializable()
class IngredientDetailResponse {
  final int status;
  final String message;
  final IngredientDetailData data;

  IngredientDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory IngredientDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$IngredientDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientDetailResponseToJson(this);
}

@JsonSerializable()
class IngredientDetailData {
  @JsonKey(name: 'ingredient_name')
  final String ingredientName;
  @JsonKey(name: 'ingredient_quantity')
  final String ingredientQuantity;
  @JsonKey(name: 'stock_amount')
  final int stockAmount;
  @JsonKey(name: 'ingredient_url')
  final List<String> ingredientUrl;
  @JsonKey(name: 'ingredient_less_than')
  final int ingredientLessThan;
  final List<IngredientStock> stocks;

  IngredientDetailData({
    required this.ingredientName,
    required this.ingredientQuantity,
    required this.stockAmount,
    required this.ingredientUrl,
    required this.ingredientLessThan,
    required this.stocks,
  });

  factory IngredientDetailData.fromJson(Map<String, dynamic> json) =>
      _$IngredientDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientDetailDataToJson(this);
}

@JsonSerializable()
class IngredientStock {
  @JsonKey(name: 'stock_id')
  final String stockId;
  @JsonKey(name: 'stock_url')
  final String stockUrl;
  final String price;
  final String quantity;
  @JsonKey(name: 'expiration_date')
  final String expirationDate;
  @JsonKey(name: 'expiration_status')
  final ExpirationStatus expirationStatus;

  IngredientStock({
    required this.stockId,
    required this.stockUrl,
    required this.price,
    required this.quantity,
    required this.expirationDate,
    required this.expirationStatus,
  });

  factory IngredientStock.fromJson(Map<String, dynamic> json) =>
      _$IngredientStockFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientStockToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'add_edit_ingredient_stock_detail.g.dart';

@JsonSerializable()
class AddEditIngredientStockDetailResponse {
  final int status;
  final String message;
  final AddEditIngredientStockDetailData data;

  AddEditIngredientStockDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddEditIngredientStockDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddEditIngredientStockDetailResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AddEditIngredientStockDetailResponseToJson(this);
}

@JsonSerializable()
class AddEditIngredientStockDetailData {
  @JsonKey(name: 'ingredient_eng_name')
  final String ingredientEngName;
  @JsonKey(name: 'ingredient_thai_name')
  final String ingredientThaiName;
  final String unit;

  AddEditIngredientStockDetailData({
    required this.ingredientEngName,
    required this.ingredientThaiName,
    required this.unit,
  });

  factory AddEditIngredientStockDetailData.fromJson(
          Map<String, dynamic> json) =>
      _$AddEditIngredientStockDetailDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AddEditIngredientStockDetailDataToJson(this);
}

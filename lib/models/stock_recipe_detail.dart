import 'package:json_annotation/json_annotation.dart';

part 'stock_recipe_detail.g.dart';

@JsonSerializable()
class StockRecipeDetailResponse {
  final int status;
  final String message;
  final StockRecipeDetailData data;

  StockRecipeDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StockRecipeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StockRecipeDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockRecipeDetailResponseToJson(this);
}

@JsonSerializable()
class StockRecipeDetailData {
  @JsonKey(name: 'recipe_name')
  final String recipeName;
  @JsonKey(name: 'total_time')
  final String totalTime;
  final int servings;
  final List<StockRecipeIngredientData> ingredients;

  StockRecipeDetailData({
    required this.recipeName,
    required this.totalTime,
    required this.servings,
    required this.ingredients,
  });

  factory StockRecipeDetailData.fromJson(Map<String, dynamic> json) =>
      _$StockRecipeDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockRecipeDetailDataToJson(this);
}

@JsonSerializable()
class StockRecipeIngredientData {
  @JsonKey(name: 'ingredient_id')
  final String ingredientId;
  @JsonKey(name: 'ingredient_name')
  final String ingredientName;
  @JsonKey(name: 'ingredient_url')
  final String ingredientUrl;
  @JsonKey(name: 'ingredient_quantity')
  final double ingredientQuantity;
  @JsonKey(name: 'stock_quantity')
  final double stockQuantity;
  final String unit;

  StockRecipeIngredientData({
    required this.ingredientId,
    required this.ingredientName,
    required this.ingredientUrl,
    required this.ingredientQuantity,
    required this.stockQuantity,
    required this.unit,
  });

  factory StockRecipeIngredientData.fromJson(Map<String, dynamic> json) =>
      _$StockRecipeIngredientDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockRecipeIngredientDataToJson(this);
}

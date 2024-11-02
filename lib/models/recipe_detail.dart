import 'package:json_annotation/json_annotation.dart';

part 'recipe_detail.g.dart';

@JsonSerializable()
class RecipeDetailResponse {
  final int status;
  final String message;
  final RecipeDetailData data;

  RecipeDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RecipeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDetailResponseToJson(this);
}

@JsonSerializable()
class RecipeDetailData {
  final int status;
  @JsonKey(name: 'recipe_name')
  final String recipeName;
  @JsonKey(name: 'recipe_url')
  final List<String>? recipeUrl;
  @JsonKey(name: 'total_time')
  final String totalTime;
  final int servings;
  final int stars;
  @JsonKey(name: 'num_of_order')
  final int numOfOrder;
  @JsonKey(name: 'recipe_ingredients')
  final List<RecipeIngredient>? recipeIngredients;
  @JsonKey(name: 'instruction_url')
  final List<String>? instructionUrl;
  @JsonKey(name: 'instruction_steps')
  final String instructionSteps;

  RecipeDetailData({
    required this.status,
    required this.recipeName,
    this.recipeUrl,
    required this.totalTime,
    required this.servings,
    required this.stars,
    required this.numOfOrder,
    this.recipeIngredients,
    this.instructionUrl,
    required this.instructionSteps,
  });

  factory RecipeDetailData.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDetailDataToJson(this);
}

@JsonSerializable()
class RecipeIngredient {
  @JsonKey(name: 'ingredient_name')
  final String ingredientName;
  @JsonKey(name: 'ingredient_url')
  final String ingredientUrl;
  @JsonKey(name: 'ingredient_quantity')
  final String ingredientQuantity;
  @JsonKey(name: 'ingredient_price')
  final double ingredientPrice;

  RecipeIngredient({
    required this.ingredientName,
    required this.ingredientUrl,
    required this.ingredientQuantity,
    required this.ingredientPrice,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeIngredientToJson(this);
}

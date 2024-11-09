import 'package:json_annotation/json_annotation.dart';

part 'get_edit_recipe_detail.g.dart';

@JsonSerializable()
class GetEditRecipeDetailResponse {
  final int status;
  final String message;
  final RecipeDetailData data;

  GetEditRecipeDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetEditRecipeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetEditRecipeDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetEditRecipeDetailResponseToJson(this);
}

@JsonSerializable()
class RecipeDetailData {
  @JsonKey(name: 'recipe_eng_name')
  final String recipeEngName;
  @JsonKey(name: 'recipe_thai_name')
  final String recipeThaiName;
  @JsonKey(name: 'total_hours')
  final String totalHours;
  @JsonKey(name: 'total_mins')
  final String totalMins;
  final String servings;
  @JsonKey(name: 'eng_instruction')
  final String engInstruction;
  @JsonKey(name: 'thai_instruction')
  final String thaiInstruction;
  final List<Ingredient> ingredients;

  RecipeDetailData({
    required this.recipeEngName,
    required this.recipeThaiName,
    required this.totalHours,
    required this.totalMins,
    required this.servings,
    required this.engInstruction,
    required this.thaiInstruction,
    required this.ingredients,
  });

  factory RecipeDetailData.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDetailDataToJson(this);
}

@JsonSerializable()
class Ingredient {
  @JsonKey(name: 'ingredient_id')
  final String ingredientId;
  @JsonKey(name: 'ingredient_name')
  final String ingredientName;
  @JsonKey(name: 'ingredient_url')
  final String ingredientUrl;
  @JsonKey(name: 'ingredient_quantity')
  final String ingredientQuantity;
  @JsonKey(name: 'ingredient_unit')
  final String ingredientUnit;

  Ingredient({
    required this.ingredientId,
    required this.ingredientName,
    required this.ingredientUrl,
    required this.ingredientQuantity,
    required this.ingredientUnit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

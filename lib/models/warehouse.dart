import 'package:json_annotation/json_annotation.dart';

part 'warehouse.g.dart';

@JsonSerializable()
class IngredietnListResponse {
  final int status;
  final String message;
  final IngredientListData data;

  IngredietnListResponse(
      {required this.status, required this.message, required this.data});

  factory IngredietnListResponse.fromJson(Map<String, dynamic> json) =>
      _$IngredietnListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$IngredietnListResponseToJson(this);
}

@JsonSerializable()
class IngredientListData {
  @JsonKey(name: 'ingredients')
  final List<IngredientItemData> ingredientList;

  IngredientListData({
    required this.ingredientList,
  });

  factory IngredientListData.fromJson(Map<String, dynamic> json) =>
      _$IngredientListDataFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientListDataToJson(this);
}

@JsonSerializable()
class IngredientItemData {
  @JsonKey(name: 'ingredient_id')
  final String ingredientId;
  @JsonKey(name: 'ingredient_name')
  final String ingredientName;
  final String quantity;
  final int stock;
  @JsonKey(name: 'ingredient_url')
  final String ingredientUrl;
  @JsonKey(name: 'expiration_status')
  final String expirationStatus;

  IngredientItemData({
    required this.ingredientId,
    required this.ingredientName,
    required this.quantity,
    required this.stock,
    required this.ingredientUrl,
    required this.expirationStatus,
  });

  factory IngredientItemData.fromJson(Map<String, dynamic> json) =>
      _$IngredientItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientItemDataToJson(this);
}

@JsonSerializable()
class RecipeListResponse {
  final int status;
  final String message;
  final RecipeListData data;

  RecipeListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RecipeListResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeListResponseToJson(this);
}

@JsonSerializable()
class RecipeListData {
  @JsonKey(name: 'recipes')
  final List<RecipeItemData> recipeList;

  RecipeListData({
    required this.recipeList,
  });

  factory RecipeListData.fromJson(Map<String, dynamic> json) =>
      _$RecipeListDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeListDataToJson(this);
}

@JsonSerializable()
class RecipeItemData {
  @JsonKey(name: 'recipe_id')
  final String recipeID;
  @JsonKey(name: 'recipe_name')
  final String recipeName;
  @JsonKey(name: 'recipe_img')
  final String recipeImg;
  @JsonKey(name: 'total_time')
  final String totalTime;
  final int servings;
  final int stars;
  @JsonKey(name: 'num_of_order')
  final int numOfOrder;

  RecipeItemData({
    required this.recipeID,
    required this.recipeName,
    required this.recipeImg,
    required this.totalTime,
    required this.servings,
    required this.stars,
    required this.numOfOrder,
  });

  factory RecipeItemData.fromJson(Map<String, dynamic> json) =>
      _$RecipeItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeItemDataToJson(this);
}

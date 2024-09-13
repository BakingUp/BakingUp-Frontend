// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredietnListResponse _$IngredietnListResponseFromJson(
        Map<String, dynamic> json) =>
    IngredietnListResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: IngredientListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IngredietnListResponseToJson(
        IngredietnListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

IngredientListData _$IngredientListDataFromJson(Map<String, dynamic> json) =>
    IngredientListData(
      ingredientList: (json['ingredients'] as List<dynamic>)
          .map((e) => IngredientItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientListDataToJson(IngredientListData instance) =>
    <String, dynamic>{
      'ingredients': instance.ingredientList,
    };

IngredientItemData _$IngredientItemDataFromJson(Map<String, dynamic> json) =>
    IngredientItemData(
      ingredientId: json['ingredient_id'] as String,
      ingredientName: json['ingredient_name'] as String,
      quantity: json['quantity'] as String,
      stock: (json['stock'] as num).toInt(),
      ingredientUrl: json['ingredient_url'] as String,
      expirationStatus: json['expiration_status'] as String,
    );

Map<String, dynamic> _$IngredientItemDataToJson(IngredientItemData instance) =>
    <String, dynamic>{
      'ingredient_id': instance.ingredientId,
      'ingredient_name': instance.ingredientName,
      'quantity': instance.quantity,
      'stock': instance.stock,
      'ingredient_url': instance.ingredientUrl,
      'expiration_status': instance.expirationStatus,
    };

RecipeListResponse _$RecipeListResponseFromJson(Map<String, dynamic> json) =>
    RecipeListResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: RecipeListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeListResponseToJson(RecipeListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

RecipeListData _$RecipeListDataFromJson(Map<String, dynamic> json) =>
    RecipeListData(
      recipeList: (json['recipes'] as List<dynamic>)
          .map((e) => RecipeItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeListDataToJson(RecipeListData instance) =>
    <String, dynamic>{
      'recipes': instance.recipeList,
    };

RecipeItemData _$RecipeItemDataFromJson(Map<String, dynamic> json) =>
    RecipeItemData(
      recipeName: json['recipe_name'] as String,
      recipeImg: json['recipe_img'] as String,
      totalTime: json['total_time'] as String,
      servings: (json['servings'] as num).toInt(),
      stars: (json['stars'] as num).toInt(),
      numOfOrder: (json['num_of_order'] as num).toInt(),
    );

Map<String, dynamic> _$RecipeItemDataToJson(RecipeItemData instance) =>
    <String, dynamic>{
      'recipe_name': instance.recipeName,
      'recipe_img': instance.recipeImg,
      'total_time': instance.totalTime,
      'servings': instance.servings,
      'stars': instance.stars,
      'num_of_order': instance.numOfOrder,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_recipe_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRecipeDetailResponse _$StockRecipeDetailResponseFromJson(
        Map<String, dynamic> json) =>
    StockRecipeDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data:
          StockRecipeDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockRecipeDetailResponseToJson(
        StockRecipeDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StockRecipeDetailData _$StockRecipeDetailDataFromJson(
        Map<String, dynamic> json) =>
    StockRecipeDetailData(
      recipeName: json['recipe_name'] as String,
      totalTime: json['total_time'] as String,
      servings: (json['servings'] as num).toInt(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) =>
              StockRecipeIngredientData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockRecipeDetailDataToJson(
        StockRecipeDetailData instance) =>
    <String, dynamic>{
      'recipe_name': instance.recipeName,
      'total_time': instance.totalTime,
      'servings': instance.servings,
      'ingredients': instance.ingredients,
    };

StockRecipeIngredientData _$StockRecipeIngredientDataFromJson(
        Map<String, dynamic> json) =>
    StockRecipeIngredientData(
      ingredientId: json['ingredient_id'] as String,
      ingredientName: json['ingredient_name'] as String,
      ingredientUrl: json['ingredient_url'] as String,
      ingredientQuantity: (json['ingredient_quantity'] as num).toDouble(),
      stockQuantity: (json['stock_quantity'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$StockRecipeIngredientDataToJson(
        StockRecipeIngredientData instance) =>
    <String, dynamic>{
      'ingredient_id': instance.ingredientId,
      'ingredient_name': instance.ingredientName,
      'ingredient_url': instance.ingredientUrl,
      'ingredient_quantity': instance.ingredientQuantity,
      'stock_quantity': instance.stockQuantity,
      'unit': instance.unit,
    };

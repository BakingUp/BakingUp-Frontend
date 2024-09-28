// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDetailResponse _$RecipeDetailResponseFromJson(
        Map<String, dynamic> json) =>
    RecipeDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: RecipeDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeDetailResponseToJson(
        RecipeDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

RecipeDetailData _$RecipeDetailDataFromJson(Map<String, dynamic> json) =>
    RecipeDetailData(
      status: (json['status'] as num).toInt(),
      recipeName: json['recipe_name'] as String,
      recipeUrl: (json['recipe_url'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      totalTime: json['total_time'] as String,
      servings: (json['servings'] as num).toInt(),
      stars: (json['stars'] as num).toInt(),
      numOfOrder: (json['num_of_order'] as num).toInt(),
      recipeIngredients: (json['recipe_ingredients'] as List<dynamic>)
          .map((e) => RecipeIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructionUrl: (json['instruction_url'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructionSteps: (json['instruction_steps'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RecipeDetailDataToJson(RecipeDetailData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'recipe_name': instance.recipeName,
      'recipe_url': instance.recipeUrl,
      'total_time': instance.totalTime,
      'servings': instance.servings,
      'stars': instance.stars,
      'num_of_order': instance.numOfOrder,
      'recipe_ingredients': instance.recipeIngredients,
      'instruction_url': instance.instructionUrl,
      'instruction_steps': instance.instructionSteps,
    };

RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) =>
    RecipeIngredient(
      ingredientName: json['ingredient_name'] as String,
      ingredientUrl: json['ingredient_url'] as String,
      ingredientQuantity: json['ingredient_quantity'] as String,
      ingredientPrice: (json['ingredient_price'] as num).toDouble(),
    );

Map<String, dynamic> _$RecipeIngredientToJson(RecipeIngredient instance) =>
    <String, dynamic>{
      'ingredient_name': instance.ingredientName,
      'ingredient_url': instance.ingredientUrl,
      'ingredient_quantity': instance.ingredientQuantity,
      'ingredient_price': instance.ingredientPrice,
    };

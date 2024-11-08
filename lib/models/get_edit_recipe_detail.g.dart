// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_edit_recipe_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEditRecipeDetailResponse _$GetEditRecipeDetailResponseFromJson(
        Map<String, dynamic> json) =>
    GetEditRecipeDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: RecipeDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetEditRecipeDetailResponseToJson(
        GetEditRecipeDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

RecipeDetailData _$RecipeDetailDataFromJson(Map<String, dynamic> json) =>
    RecipeDetailData(
      recipeEngName: json['recipe_eng_name'] as String,
      recipeThaiName: json['recipe_thai_name'] as String,
      totalHours: json['total_hours'] as String,
      totalMins: json['total_mins'] as String,
      servings: json['servings'] as String,
      engInstruction: json['eng_instruction'] as String,
      thaiInstruction: json['thai_instruction'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeDetailDataToJson(RecipeDetailData instance) =>
    <String, dynamic>{
      'recipe_eng_name': instance.recipeEngName,
      'recipe_thai_name': instance.recipeThaiName,
      'total_hours': instance.totalHours,
      'total_mins': instance.totalMins,
      'servings': instance.servings,
      'eng_instruction': instance.engInstruction,
      'thai_instruction': instance.thaiInstruction,
      'ingredients': instance.ingredients,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      ingredientId: json['ingredient_id'] as String,
      ingredientName: json['ingredient_name'] as String,
      ingredientUrl: json['ingredient_url'] as String,
      ingredientQuantity: json['ingredient_quantity'] as String,
      ingredientUnit: json['ingredient_unit'] as String,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'ingredient_id': instance.ingredientId,
      'ingredient_name': instance.ingredientName,
      'ingredient_url': instance.ingredientUrl,
      'ingredient_quantity': instance.ingredientQuantity,
      'ingredient_unit': instance.ingredientUnit,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_ingredient_ids_and_names.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllIngredientIdsAndNamesResponse
    _$GetAllIngredientIdsAndNamesResponseFromJson(Map<String, dynamic> json) =>
        GetAllIngredientIdsAndNamesResponse(
          status: (json['status'] as num).toInt(),
          message: json['message'] as String,
          data: IngredientData.fromJson(json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetAllIngredientIdsAndNamesResponseToJson(
        GetAllIngredientIdsAndNamesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

IngredientData _$IngredientDataFromJson(Map<String, dynamic> json) =>
    IngredientData(
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientDataToJson(IngredientData instance) =>
    <String, dynamic>{
      'ingredients': instance.ingredients,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      ingredientId: json['ingredient_id'] as String,
      ingredientEngName: json['ingredient_eng_name'] as String,
      ingredientThaiName: json['ingredient_thai_name'] as String,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'ingredient_id': instance.ingredientId,
      'ingredient_eng_name': instance.ingredientEngName,
      'ingredient_thai_name': instance.ingredientThaiName,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_ingredient_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEditIngredientDetailResponse _$AddEditIngredientDetailResponseFromJson(
        Map<String, dynamic> json) =>
    AddEditIngredientDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data:
          AddEditIngredientData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddEditIngredientDetailResponseToJson(
        AddEditIngredientDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

AddEditIngredientData _$AddEditIngredientDataFromJson(
        Map<String, dynamic> json) =>
    AddEditIngredientData(
      ingredientEngName: json['ingredient_eng_name'] as String,
      ingredientThaiName: json['ingredient_thai_name'] as String,
      unit: json['unit'] as String,
      stockLessThan: json['stock_less_than'] as String,
      dayBeforeExpire: json['day_before_expire'] as String,
    );

Map<String, dynamic> _$AddEditIngredientDataToJson(
        AddEditIngredientData instance) =>
    <String, dynamic>{
      'ingredient_eng_name': instance.ingredientEngName,
      'ingredient_thai_name': instance.ingredientThaiName,
      'unit': instance.unit,
      'stock_less_than': instance.stockLessThan,
      'day_before_expire': instance.dayBeforeExpire,
    };

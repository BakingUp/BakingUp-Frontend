// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_ingredient_stock_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEditIngredientStockDetailResponse
    _$AddEditIngredientStockDetailResponseFromJson(Map<String, dynamic> json) =>
        AddEditIngredientStockDetailResponse(
          status: (json['status'] as num).toInt(),
          message: json['message'] as String,
          data: AddEditIngredientStockDetailData.fromJson(
              json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AddEditIngredientStockDetailResponseToJson(
        AddEditIngredientStockDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

AddEditIngredientStockDetailData _$AddEditIngredientStockDetailDataFromJson(
        Map<String, dynamic> json) =>
    AddEditIngredientStockDetailData(
      ingredientEngName: json['ingredient_eng_name'] as String,
      ingredientThaiName: json['ingredient_thai_name'] as String,
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$AddEditIngredientStockDetailDataToJson(
        AddEditIngredientStockDetailData instance) =>
    <String, dynamic>{
      'ingredient_eng_name': instance.ingredientEngName,
      'ingredient_thai_name': instance.ingredientThaiName,
      'unit': instance.unit,
    };

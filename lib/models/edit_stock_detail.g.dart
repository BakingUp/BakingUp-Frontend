// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_stock_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditStockDetailResponse _$EditStockDetailResponseFromJson(
        Map<String, dynamic> json) =>
    EditStockDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: EditStockDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditStockDetailResponseToJson(
        EditStockDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

EditStockDetailData _$EditStockDetailDataFromJson(Map<String, dynamic> json) =>
    EditStockDetailData(
      lst: json['lst'] as String,
      recipeName: json['recipe_name'] as String,
      recipeUrl: json['recipe_url'] as String,
      sellingPrice: json['selling_price'] as String,
      stockLessThan: json['stock_less_than'] as String,
      expirationDate: json['expiration_date'] as String,
    );

Map<String, dynamic> _$EditStockDetailDataToJson(
        EditStockDetailData instance) =>
    <String, dynamic>{
      'lst': instance.lst,
      'recipe_name': instance.recipeName,
      'recipe_url': instance.recipeUrl,
      'selling_price': instance.sellingPrice,
      'stock_less_than': instance.stockLessThan,
      'expiration_date': instance.expirationDate,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientDetailResponse _$IngredientDetailResponseFromJson(
        Map<String, dynamic> json) =>
    IngredientDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: IngredientDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IngredientDetailResponseToJson(
        IngredientDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

IngredientDetailData _$IngredientDetailDataFromJson(
        Map<String, dynamic> json) =>
    IngredientDetailData(
      ingredientName: json['ingredient_name'] as String,
      ingredientQuantity: json['ingredient_quantity'] as String,
      stockAmount: (json['stock_amount'] as num).toInt(),
      ingredientUrl: (json['ingredient_url'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ingredientLessThan: (json['ingredient_less_than'] as num).toInt(),
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => IngredientStock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientDetailDataToJson(
        IngredientDetailData instance) =>
    <String, dynamic>{
      'ingredient_name': instance.ingredientName,
      'ingredient_quantity': instance.ingredientQuantity,
      'stock_amount': instance.stockAmount,
      'ingredient_url': instance.ingredientUrl,
      'ingredient_less_than': instance.ingredientLessThan,
      'stocks': instance.stocks,
    };

IngredientStock _$IngredientStockFromJson(Map<String, dynamic> json) =>
    IngredientStock(
      stockId: json['stock_id'] as String,
      stockUrl: json['stock_url'] as String,
      price: json['price'] as String,
      quantity: json['quantity'] as String,
      expirationDate: json['expiration_date'] as String,
      expirationStatus:
          $enumDecode(_$ExpirationStatusEnumMap, json['expiration_status']),
    );

Map<String, dynamic> _$IngredientStockToJson(IngredientStock instance) =>
    <String, dynamic>{
      'stock_id': instance.stockId,
      'stock_url': instance.stockUrl,
      'price': instance.price,
      'quantity': instance.quantity,
      'expiration_date': instance.expirationDate,
      'expiration_status':
          _$ExpirationStatusEnumMap[instance.expirationStatus]!,
    };

const _$ExpirationStatusEnumMap = {
  ExpirationStatus.black: 'black',
  ExpirationStatus.red: 'red',
  ExpirationStatus.yellow: 'yellow',
  ExpirationStatus.green: 'green',
};

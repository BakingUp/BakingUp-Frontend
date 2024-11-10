// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_ingredient_stock_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditIngredientStockDetailResponse _$EditIngredientStockDetailResponseFromJson(
        Map<String, dynamic> json) =>
    EditIngredientStockDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: EditIngredientStockData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditIngredientStockDetailResponseToJson(
        EditIngredientStockDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

EditIngredientStockData _$EditIngredientStockDataFromJson(
        Map<String, dynamic> json) =>
    EditIngredientStockData(
      ingredientStockId: json['ingredient_stock_id'] as String,
      brand: json['brand'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as String,
      supplier: json['supplier'] as String,
      expirationDate: json['expiration_date'] as String,
    );

Map<String, dynamic> _$EditIngredientStockDataToJson(
        EditIngredientStockData instance) =>
    <String, dynamic>{
      'ingredient_stock_id': instance.ingredientStockId,
      'brand': instance.brand,
      'quantity': instance.quantity,
      'price': instance.price,
      'supplier': instance.supplier,
      'expiration_date': instance.expirationDate,
    };

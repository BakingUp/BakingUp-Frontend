// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_order_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOrderPageResponse _$StockOrderPageResponseFromJson(
        Map<String, dynamic> json) =>
    StockOrderPageResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StockOrderPageData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockOrderPageResponseToJson(
        StockOrderPageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StockOrderPageData _$StockOrderPageDataFromJson(Map<String, dynamic> json) =>
    StockOrderPageData(
      stocks: (json['order_stocks'] as List<dynamic>)
          .map((e) => StockOrderItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockOrderPageDataToJson(StockOrderPageData instance) =>
    <String, dynamic>{
      'order_stocks': instance.stocks,
    };

StockOrderItemData _$StockOrderItemDataFromJson(Map<String, dynamic> json) =>
    StockOrderItemData(
      json['recipe_id'] as String,
      json['recipe_name'] as String,
      json['sell_by_date'] as String,
      json['recipe_url'] as String,
      (json['profit'] as num).toDouble(),
      (json['quantity'] as num).toInt(),
      (json['selling_price'] as num).toDouble(),
    );

Map<String, dynamic> _$StockOrderItemDataToJson(StockOrderItemData instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeID,
      'recipe_name': instance.recipeName,
      'quantity': instance.quantity,
      'sell_by_date': instance.sellByDate,
      'recipe_url': instance.recipeUrl,
      'selling_price': instance.sellingPrice,
      'profit': instance.profit,
    };

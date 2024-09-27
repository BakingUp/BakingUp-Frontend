// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockListResponse _$StockListResponseFromJson(Map<String, dynamic> json) =>
    StockListResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StockListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockListResponseToJson(StockListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StockListData _$StockListDataFromJson(Map<String, dynamic> json) =>
    StockListData(
      stocks: (json['stocks'] as List<dynamic>)
          .map((e) => StockItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockListDataToJson(StockListData instance) =>
    <String, dynamic>{
      'stocks': instance.stocks,
    };

StockItemData _$StockItemDataFromJson(Map<String, dynamic> json) =>
    StockItemData(
      stockID: json['stock_id'] as String,
      stockName: json['stock_name'] as String,
      stockUrl: json['stock_url'] as String,
      quantity: (json['quantity'] as num).toInt(),
      lst: (json['lst'] as num).toInt(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      lstStatus: json['lst_status'] as String,
    );

Map<String, dynamic> _$StockItemDataToJson(StockItemData instance) =>
    <String, dynamic>{
      'stock_id': instance.stockID,
      'stock_name': instance.stockName,
      'stock_url': instance.stockUrl,
      'quantity': instance.quantity,
      'lst': instance.lst,
      'selling_price': instance.sellingPrice,
      'lst_status': instance.lstStatus,
    };

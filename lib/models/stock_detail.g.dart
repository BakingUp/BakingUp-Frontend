// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockDetailResponse _$StockDetailResponseFromJson(Map<String, dynamic> json) =>
    StockDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StockDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockDetailResponseToJson(
        StockDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StockDetailData _$StockDetailDataFromJson(Map<String, dynamic> json) =>
    StockDetailData(
      stockName: json['stock_name'] as String,
      stockUrl: (json['stock_url'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      quantity: (json['quantity'] as num).toInt(),
      lst: (json['lst'] as num).toInt(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      stockLessThan: (json['stock_less_than'] as num).toInt(),
      stockDetails: (json['stock_details'] as List<dynamic>?)
          ?.map((e) => StockDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockDetailDataToJson(StockDetailData instance) =>
    <String, dynamic>{
      'stock_name': instance.stockName,
      'stock_url': instance.stockUrl,
      'quantity': instance.quantity,
      'lst': instance.lst,
      'selling_price': instance.sellingPrice,
      'stock_less_than': instance.stockLessThan,
      'stock_details': instance.stockDetails,
    };

StockDetail _$StockDetailFromJson(Map<String, dynamic> json) => StockDetail(
      stockDetailId: json['stock_detail_id'] as String,
      createdAt: json['created_at'] as String,
      lstStatus: $enumDecode(_$LSTStatusEnumMap, json['lst_status']),
      quantity: (json['quantity'] as num).toInt(),
      sellByDate: json['sell_by_date'] as String,
    );

Map<String, dynamic> _$StockDetailToJson(StockDetail instance) =>
    <String, dynamic>{
      'stock_detail_id': instance.stockDetailId,
      'created_at': instance.createdAt,
      'lst_status': _$LSTStatusEnumMap[instance.lstStatus]!,
      'quantity': instance.quantity,
      'sell_by_date': instance.sellByDate,
    };

const _$LSTStatusEnumMap = {
  LSTStatus.black: 'black',
  LSTStatus.red: 'red',
  LSTStatus.yellow: 'yellow',
  LSTStatus.green: 'green',
};

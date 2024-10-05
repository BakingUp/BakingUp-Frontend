// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockBatchResponse _$StockBatchResponseFromJson(Map<String, dynamic> json) =>
    StockBatchResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StockBatchData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockBatchResponseToJson(StockBatchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StockBatchData _$StockBatchDataFromJson(Map<String, dynamic> json) =>
    StockBatchData(
      stockDetailId: json['stock_detail_id'] as String,
      recipeName: json['recipe_name'] as String,
      recipeUrl: json['recipe_url'] as String,
      quantity: (json['quantity'] as num).toInt(),
      sellByDate: json['sell_by_date'] as String,
      note: json['note'] as String,
      noteCreatedAt: json['note_created_at'] as String,
    );

Map<String, dynamic> _$StockBatchDataToJson(StockBatchData instance) =>
    <String, dynamic>{
      'stock_detail_id': instance.stockDetailId,
      'recipe_name': instance.recipeName,
      'recipe_url': instance.recipeUrl,
      'quantity': instance.quantity,
      'sell_by_date': instance.sellByDate,
      'note': instance.note,
      'note_created_at': instance.noteCreatedAt,
    };

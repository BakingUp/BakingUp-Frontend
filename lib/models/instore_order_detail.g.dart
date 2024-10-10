// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instore_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstoreOrderDetailResponse _$InstoreOrderDetailResponseFromJson(
        Map<String, dynamic> json) =>
    InstoreOrderDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data:
          InstoreOrderDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstoreOrderDetailResponseToJson(
        InstoreOrderDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

InstoreOrderDetailData _$InstoreOrderDetailDataFromJson(
        Map<String, dynamic> json) =>
    InstoreOrderDetailData(
      orderIndex: (json['order_index'] as num).toInt(),
      orderStatus: statusFromJson(json['order_status'] as String),
      orderPlatform: platformFromJson(json['order_platform'] as String),
      orderDate: json['order_date'] as String,
      orderTime: json['order_time'] as String,
      orderType: typeFromJson(json['order_type'] as String),
      orderTakenBy: json['order_taken_by'] as String,
      orderStockList: (json['order_stock'] as List<dynamic>)
          .map((e) => OrderStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      orderNoteText: json['order_note_text'] as String?,
      orderNoteCreateAt: json['order_note_create_at'] as String?,
    );

Map<String, dynamic> _$InstoreOrderDetailDataToJson(
        InstoreOrderDetailData instance) =>
    <String, dynamic>{
      'order_index': instance.orderIndex,
      'order_status': statusToJson(instance.orderStatus),
      'order_platform': platformToJson(instance.orderPlatform),
      'order_date': instance.orderDate,
      'order_time': instance.orderTime,
      'order_type': typeToJson(instance.orderType),
      'order_taken_by': instance.orderTakenBy,
      'order_stock': instance.orderStockList,
      'total': instance.total,
      'profit': instance.profit,
      'order_note_text': instance.orderNoteText,
      'order_note_create_at': instance.orderNoteCreateAt,
    };

OrderStock _$OrderStockFromJson(Map<String, dynamic> json) => OrderStock(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      stockPrice: (json['stock_price'] as num).toDouble(),
      imgUrl: json['recipe_url'] as String,
    );

Map<String, dynamic> _$OrderStockToJson(OrderStock instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'stock_price': instance.stockPrice,
      'recipe_url': instance.imgUrl,
    };

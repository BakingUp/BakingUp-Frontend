// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preorder_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreorderOrderDetailResponse _$PreorderOrderDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PreorderOrderDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: PreorderOrderDetailData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreorderOrderDetailResponseToJson(
        PreorderOrderDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

PreorderOrderDetailData _$PreorderOrderDetailDataFromJson(
        Map<String, dynamic> json) =>
    PreorderOrderDetailData(
      orderIndex: (json['order_index'] as num).toInt(),
      customerName: json['customer_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      orderStatus: statusFromJson(json['order_status'] as String),
      orderPlatform: platformFromJson(json['order_platform'] as String),
      orderDate: json['order_date'] as String,
      orderTime: json['order_time'] as String,
      orderType: typeFromJson(json['order_type'] as String),
      pickUpDate: json['pick_up_date'] as String,
      pickUpTime: json['pick_up_time'] as String,
      pickUpMethod: methodFromJson(json['pick_up_method'] as String),
      orderTakenBy: json['order_taken_by'] as String,
      orderStockList: (json['order_stock'] as List<dynamic>)
          .map((e) => OrderStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      orderNoteText: json['order_note_text'] as String?,
      orderNoteCreateAt: json['order_note_create_at'] as String?,
    );

Map<String, dynamic> _$PreorderOrderDetailDataToJson(
        PreorderOrderDetailData instance) =>
    <String, dynamic>{
      'order_index': instance.orderIndex,
      'customer_name': instance.customerName,
      'phone_number': instance.phoneNumber,
      'order_status': statusToJson(instance.orderStatus),
      'order_platform': platformToJson(instance.orderPlatform),
      'order_date': instance.orderDate,
      'order_time': instance.orderTime,
      'order_type': typeToJson(instance.orderType),
      'pick_up_date': instance.pickUpDate,
      'pick_up_time': instance.pickUpTime,
      'pick_up_method': methodToJson(instance.pickUpMethod),
      'order_taken_by': instance.orderTakenBy,
      'order_stock': instance.orderStockList,
      'total': instance.total,
      'profit': instance.profit,
      'order_note_text': instance.orderNoteText,
      'order_note_create_at': instance.orderNoteCreateAt,
    };

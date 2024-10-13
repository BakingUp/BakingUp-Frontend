// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersResponse _$OrdersResponseFromJson(Map<String, dynamic> json) =>
    OrdersResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: Orders.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrdersResponseToJson(OrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'orders': instance.orders,
    };

OrderInfo _$OrderInfoFromJson(Map<String, dynamic> json) => OrderInfo(
      orderId: json['order_id'] as String,
      orderIndex: (json['order_index'] as num).toInt(),
      orderPlatform: platformFromJson(json['order_platform'] as String),
      isPreOrder: json['is_pre_order'] as bool,
      total: (json['total'] as num).toDouble(),
      orderDate: json['order_date'] as String,
      pickUpDate: json['pick_up_date'] as String,
      orderStatus: statusFromJson(json['order_status'] as String),
    );

Map<String, dynamic> _$OrderInfoToJson(OrderInfo instance) => <String, dynamic>{
      'order_id': instance.orderId,
      'order_index': instance.orderIndex,
      'order_platform': platformToJson(instance.orderPlatform),
      'is_pre_order': instance.isPreOrder,
      'total': instance.total,
      'order_date': instance.orderDate,
      'pick_up_date': instance.pickUpDate,
      'order_status': statusToJson(instance.orderStatus),
    };

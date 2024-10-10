import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrdersResponse {
  final int status;
  final String message;
  final Orders data;

  OrdersResponse({required this.status, required this.message, required this.data});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
}

@JsonSerializable()
class Orders {
  final List<OrderInfo> orders;

  Orders({required this.orders});

  factory Orders.fromJson(Map<String, dynamic> json) =>
      _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}

@JsonSerializable()
class OrderInfo {
  @JsonKey(name: 'order_id')
  final String orderId;
  
  @JsonKey(name: 'order_index')
  final int orderIndex;
  
  @JsonKey(name: 'order_platform', fromJson: platformFromJson, toJson: platformToJson)
  final OrderPlatform orderPlatform;

  @JsonKey(name: 'is_pre_order')
  final bool isPreOrder;

  final double total;

  @JsonKey(name: 'order_date')
  final String orderDate;

  @JsonKey(name: 'pick_up_date')
  final String pickUpDate;

  @JsonKey(name: 'order_status', fromJson: statusFromJson, toJson: statusToJson)
  final OrderStatus orderStatus;

  OrderInfo({
    required this.orderId,
    required this.orderIndex,
    required this.orderPlatform,
    required this.isPreOrder,
    required this.total,
    required this.orderDate,
    required this.pickUpDate,
    required this.orderStatus,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderInfoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderInfoToJson(this);
}


// OrderPlatform _platformFromJson(String platform) {
//   switch (platform) {
//     case 'STORE':
//       return OrderPlatform.STORE;
//     case 'LINEMAN':
//       return OrderPlatform.LINEMAN;
//     case 'GRAB':
//       return OrderPlatform.GRAB;
//     case 'FACEBOOK':
//       return OrderPlatform.FACEBOOK;
//     case 'WEBSITE':
//       return OrderPlatform.WEBSITE;
//     case 'OTHER':
//       return OrderPlatform.OTHER;
//     default:
//       throw ArgumentError('Unknown OrderPlatform: $platform');
//   }
// }

// String _platformToJson(OrderPlatform platform) {
//   return platform.toString().split('.').last;
// }


// OrderStatus _statusFromJson(String status) {
//   switch (status) {
//     case 'DONE':
//       return OrderStatus.DONE;
//     case 'IN_PROCESS':
//       return OrderStatus.IN_PROCESS;
//     case 'CANCEL':
//       return OrderStatus.CANCEL;
//     default:
//       throw ArgumentError('Unknown OrderStatus: $status');
//   }
// }

// String _statusToJson(OrderStatus status) {
//   return status.toString().split('.').last;
// }

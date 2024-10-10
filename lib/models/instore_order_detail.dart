import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instore_order_detail.g.dart';

@JsonSerializable()
class InstoreOrderDetailResponse {
  final int status;
  final String message;
  final InstoreOrderDetailData data;

  InstoreOrderDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InstoreOrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$InstoreOrderDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InstoreOrderDetailResponseToJson(this);
}

@JsonSerializable()
class InstoreOrderDetailData {
  @JsonKey(name: 'order_index')
  final int orderIndex;

  @JsonKey(name: 'order_status', fromJson: statusFromJson, toJson: statusToJson)
  final OrderStatus orderStatus;

  @JsonKey(
      name: 'order_platform',
      fromJson: platformFromJson,
      toJson: platformToJson)
  final OrderPlatform orderPlatform;
  @JsonKey(name: 'order_date')
  final String orderDate;
  @JsonKey(name: 'order_time')
  final String orderTime;
  @JsonKey(name: 'order_type', fromJson: typeFromJson, toJson: typeToJson)
  final OrderType orderType;
  @JsonKey(name: 'order_taken_by')
  final String orderTakenBy;
  @JsonKey(name: 'order_stock')
  final List<OrderStock> orderStockList;
  final double total;
  final double profit;
  @JsonKey(name: 'order_note_text')
  final String? orderNoteText;
  @JsonKey(name: 'order_note_create_at')
  final String? orderNoteCreateAt;
  InstoreOrderDetailData({
    required this.orderIndex,
    required this.orderStatus,
    required this.orderPlatform,
    required this.orderDate,
    required this.orderTime,
    required this.orderType,
    required this.orderTakenBy,
    required this.orderStockList,
    required this.total,
    required this.profit,
    required this.orderNoteText,
    required this.orderNoteCreateAt,
  });

  factory InstoreOrderDetailData.fromJson(Map<String, dynamic> json) =>
      _$InstoreOrderDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$InstoreOrderDetailDataToJson(this);
}

@JsonSerializable()
class OrderStock {
  final String name;
  final int quantity;
  @JsonKey(name: 'stock_price')
  final double stockPrice;
  @JsonKey(name: 'recipe_url')
  final String imgUrl;

  OrderStock({
    required this.name,
    required this.quantity,
    required this.stockPrice,
    required this.imgUrl,
  });

  factory OrderStock.fromJson(Map<String, dynamic> json) =>
      _$OrderStockFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStockToJson(this);
}

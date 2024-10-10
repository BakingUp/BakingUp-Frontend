import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:bakingup_frontend/enum/pick_up_method.dart';
import 'package:bakingup_frontend/models/instore_order_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preorder_order_detail.g.dart';

@JsonSerializable()
class PreorderOrderDetailResponse {
  final int status;
  final String message;
  final PreorderOrderDetailData data;

  PreorderOrderDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PreorderOrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PreorderOrderDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PreorderOrderDetailResponseToJson(this);
}

@JsonSerializable()
class PreorderOrderDetailData {  
  @JsonKey(name: 'order_index')
  final int orderIndex;
  @JsonKey(name: 'customer_name')
  final String? customerName;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'order_status', fromJson: statusFromJson, toJson: statusToJson)
  final OrderStatus orderStatus;
  @JsonKey(name: 'order_platform', fromJson: platformFromJson, toJson: platformToJson)
  final OrderPlatform orderPlatform;
  @JsonKey(name: 'order_date')
  final String orderDate;
  @JsonKey(name: 'order_time')
  final String orderTime;
  @JsonKey(name: 'order_type', fromJson: typeFromJson, toJson: typeToJson)
  final OrderType orderType;
  @JsonKey(name: 'pick_up_date')
  final String pickUpDate;
  @JsonKey(name: 'pick_up_time')
  final String pickUpTime;
  @JsonKey(name: 'pick_up_method', fromJson: methodFromJson, toJson: methodToJson)
  final PickUpMethod pickUpMethod;
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

  PreorderOrderDetailData({
    required this.orderIndex,
    required this.customerName,
    required this.phoneNumber,
    required this.orderStatus,
    required this.orderPlatform,
    required this.orderDate,
    required this.orderTime,
    required this.orderType,
    required this.pickUpDate,
    required this.pickUpTime,
    required this.pickUpMethod,
    required this.orderTakenBy,
    required this.orderStockList,
    required this.total,
    required this.profit,
    required this.orderNoteText,
    required this.orderNoteCreateAt,
  });

  factory PreorderOrderDetailData.fromJson(Map<String, dynamic> json) =>
      _$PreorderOrderDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$PreorderOrderDetailDataToJson(this);
}








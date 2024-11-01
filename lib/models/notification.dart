import 'package:bakingup_frontend/enum/noti_item_type.dart';
import 'package:bakingup_frontend/enum/noti_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationsResponse {
  final int status;
  final String message;
  final NotificationList data;

  NotificationsResponse(
      {required this.status, required this.message, required this.data});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationList {
  final List<NotificationItem> notis;

  NotificationList({required this.notis});

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      _$NotificationListFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationListToJson(this);
}

@JsonSerializable()
class NotificationItem {
  @JsonKey(name: 'noti_id')
  final String notiID;
  final String title;
  final String message;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'is_read')
  final bool isRead;
  @JsonKey(
      name: 'noti_type', fromJson: notiTypeFromJson, toJson: notiTypeToJson)
  final NotiType notiType;
  @JsonKey(name: 'item_id')
  final String itemID;
  @JsonKey(name: 'item_name')
  final String itemName;
  @JsonKey(
      name: 'noti_item_type',
      fromJson: notiItemTypeFromJson,
      toJson: notiItemTypeToJson)
  final NotiItemType notiItemType;

  NotificationItem(
      {required this.notiID,
      required this.title,
      required this.message,
      required this.createdAt,
      required this.isRead,
      required this.notiType,
      required this.itemID,
      required this.itemName,
      required this.notiItemType});

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
}

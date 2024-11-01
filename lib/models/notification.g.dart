// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationsResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: NotificationList.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsResponseToJson(
        NotificationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

NotificationList _$NotificationListFromJson(Map<String, dynamic> json) =>
    NotificationList(
      notis: (json['notis'] as List<dynamic>)
          .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationListToJson(NotificationList instance) =>
    <String, dynamic>{
      'notis': instance.notis,
    };

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      notiID: json['noti_id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      createdAt: json['created_at'] as String,
      isRead: json['is_read'] as bool,
      notiType: notiTypeFromJson(json['noti_type'] as String),
      itemID: json['item_id'] as String,
      itemName: json['item_name'] as String,
      notiItemType: notiItemTypeFromJson(json['noti_item_type'] as String),
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'noti_id': instance.notiID,
      'title': instance.title,
      'message': instance.message,
      'created_at': instance.createdAt,
      'is_read': instance.isRead,
      'noti_type': notiTypeToJson(instance.notiType),
      'item_id': instance.itemID,
      'item_name': instance.itemName,
      'noti_item_type': notiItemTypeToJson(instance.notiItemType),
    };

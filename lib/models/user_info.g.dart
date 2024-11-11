// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: UserInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) => UserInfoData(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      tel: json['tel'] as String,
      storeName: json['store_name'] as String,
      productionQueue: (json['production_queue'] as List<dynamic>?)
          ?.map((e) => ProductionQueue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'tel': instance.tel,
      'store_name': instance.storeName,
      'production_queue': instance.productionQueue,
    };

ProductionQueue _$ProductionQueueFromJson(Map<String, dynamic> json) =>
    ProductionQueue(
      orderIndex: json['order_index'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      pickUpDate: json['pick_up_date'] as String,
      imgUrl: json['recipe_url'] as String,
    );

Map<String, dynamic> _$ProductionQueueToJson(ProductionQueue instance) =>
    <String, dynamic>{
      'order_index': instance.orderIndex,
      'name': instance.name,
      'quantity': instance.quantity,
      'pick_up_date': instance.pickUpDate,
      'recipe_url': instance.imgUrl,
    };

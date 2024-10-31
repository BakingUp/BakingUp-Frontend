import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfoResponse {
  final int status;
  final String message;
  final UserInfoData data;

  UserInfoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}

@JsonSerializable()
class UserInfoData {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String tel;
  @JsonKey(name: 'store_name')
  final String storeName;

  UserInfoData({
    required this.firstName,
    required this.lastName,
    required this.tel,
    required this.storeName,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);
}

@JsonSerializable()
class ProductionQueue {
  @JsonKey(name: 'order_index')
  final String orderIndex;
  final String name;
  final String quantity;
  @JsonKey(name: 'pick_up_date')
  final String pickUpDate;
  @JsonKey(name: 'recipe_url')
  final String imgUrl;

  ProductionQueue({
    required this.orderIndex,
    required this.name,
    required this.quantity,
    required this.pickUpDate,
    required this.imgUrl,
  });

  factory ProductionQueue.fromJson(Map<String, dynamic> json) =>
      _$ProductionQueueFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionQueueToJson(this);
}

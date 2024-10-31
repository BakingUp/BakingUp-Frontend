import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class UserLanguageResponse {
  final int status;
  final String message;
  final UserLanguageData data;

  UserLanguageResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserLanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLanguageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserLanguageResponseToJson(this);
}

@JsonSerializable()
class UserLanguageData {
  final String language;

  UserLanguageData({required this.language});

  factory UserLanguageData.fromJson(Map<String, dynamic> json) =>
      _$UserLanguageDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserLanguageDataToJson(this);
}

@JsonSerializable()
class UserFixCostResponse {
  final int status;
  final String message;
  final UserFixCostData data;

  UserFixCostResponse(
      {required this.status, required this.message, required this.data});

  factory UserFixCostResponse.fromJson(Map<String, dynamic> json) =>
      _$UserFixCostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserFixCostResponseToJson(this);
}

@JsonSerializable()
class UserFixCostData {
  final String id;
  final double rent;
  final double salaries;
  final double insurance;
  final double subscriptions;
  final double advertising;
  final double electricity;
  final double water;
  final double gas;
  final double other;
  final String note;

  UserFixCostData({
    required this.id,
    required this.rent,
    required this.salaries,
    required this.insurance,
    required this.subscriptions,
    required this.advertising,
    required this.electricity,
    required this.water,
    required this.gas,
    required this.other,
    required this.note,
  });

  factory UserFixCostData.fromJson(Map<String, dynamic> json) =>
      _$UserFixCostDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserFixCostDataToJson(this);
}

@JsonSerializable()
class UserExpiredColorResponse {
  final int status;
  final String message;
  final UserExpiredColorData data;

  UserExpiredColorResponse(
      {required this.status, required this.message, required this.data});

  factory UserExpiredColorResponse.fromJson(Map<String, dynamic> json) =>
      _$UserExpiredColorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserExpiredColorResponseToJson(this);
}

@JsonSerializable()
class UserExpiredColorData {
  @JsonKey(name: 'black_expiration_date')
  final int blackExpirationDate;
  @JsonKey(name: 'red_expiration_date')
  final int redExpirationDate;
  @JsonKey(name: 'yellow_expiration_date')
  final int yellowExpirationDate;

  UserExpiredColorData(
      {required this.blackExpirationDate,
      required this.redExpirationDate,
      required this.yellowExpirationDate});

  factory UserExpiredColorData.fromJson(Map<String, dynamic> json) =>
      _$UserExpiredColorDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserExpiredColorDataToJson(this);
}

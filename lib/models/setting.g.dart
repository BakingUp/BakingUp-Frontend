// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLanguageResponse _$UserLanguageResponseFromJson(
        Map<String, dynamic> json) =>
    UserLanguageResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: UserLanguageData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserLanguageResponseToJson(
        UserLanguageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UserLanguageData _$UserLanguageDataFromJson(Map<String, dynamic> json) =>
    UserLanguageData(
      language: json['language'] as String,
    );

Map<String, dynamic> _$UserLanguageDataToJson(UserLanguageData instance) =>
    <String, dynamic>{
      'language': instance.language,
    };

UserFixCostResponse _$UserFixCostResponseFromJson(Map<String, dynamic> json) =>
    UserFixCostResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: UserFixCostData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserFixCostResponseToJson(
        UserFixCostResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UserFixCostData _$UserFixCostDataFromJson(Map<String, dynamic> json) =>
    UserFixCostData(
      rent: (json['rent'] as num).toDouble(),
      salaries: (json['salaries'] as num).toDouble(),
      insurance: (json['insurance'] as num).toDouble(),
      subscriptions: (json['subscriptions'] as num).toDouble(),
      advertising: (json['advertising'] as num).toDouble(),
      electricity: (json['electricity'] as num).toDouble(),
      water: (json['water'] as num).toDouble(),
      gas: (json['gas'] as num).toDouble(),
      other: (json['other'] as num).toDouble(),
    );

Map<String, dynamic> _$UserFixCostDataToJson(UserFixCostData instance) =>
    <String, dynamic>{
      'rent': instance.rent,
      'salaries': instance.salaries,
      'insurance': instance.insurance,
      'subscriptions': instance.subscriptions,
      'advertising': instance.advertising,
      'electricity': instance.electricity,
      'water': instance.water,
      'gas': instance.gas,
      'other': instance.other,
    };

UserExpiredColorResponse _$UserExpiredColorResponseFromJson(
        Map<String, dynamic> json) =>
    UserExpiredColorResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: UserExpiredColorData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserExpiredColorResponseToJson(
        UserExpiredColorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UserExpiredColorData _$UserExpiredColorDataFromJson(
        Map<String, dynamic> json) =>
    UserExpiredColorData(
      blackExpirationDate: (json['black_expiration_date'] as num).toInt(),
      redExpirationDate: (json['red_expiration_data'] as num).toInt(),
      yellowExpirationDate: (json['yellow_expiration_date'] as num).toInt(),
    );

Map<String, dynamic> _$UserExpiredColorDataToJson(
        UserExpiredColorData instance) =>
    <String, dynamic>{
      'black_expiration_date': instance.blackExpirationDate,
      'red_expiration_data': instance.redExpirationDate,
      'yellow_expiration_date': instance.yellowExpirationDate,
    };

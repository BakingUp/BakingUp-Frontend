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

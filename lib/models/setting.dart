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

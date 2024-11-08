import 'package:json_annotation/json_annotation.dart';

part 'add_edit_ingredient_detail.g.dart';

@JsonSerializable()
class AddEditIngredientDetailResponse {
  final int status;
  final String message;
  final AddEditIngredientData data;

  AddEditIngredientDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddEditIngredientDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AddEditIngredientDetailResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddEditIngredientDetailResponseToJson(this);
}

@JsonSerializable()
class AddEditIngredientData {
  @JsonKey(name: 'ingredient_eng_name')
  final String ingredientEngName;
  @JsonKey(name: 'ingredient_thai_name')
  final String ingredientThaiName;
  final String unit;
  @JsonKey(name: 'stock_less_than')
  final String stockLessThan;
  @JsonKey(name: 'day_before_expire')
  final String dayBeforeExpire;

  AddEditIngredientData({
    required this.ingredientEngName,
    required this.ingredientThaiName,
    required this.unit,
    required this.stockLessThan,
    required this.dayBeforeExpire,
  });

  factory AddEditIngredientData.fromJson(Map<String, dynamic> json) =>
      _$AddEditIngredientDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddEditIngredientDataToJson(this);
}

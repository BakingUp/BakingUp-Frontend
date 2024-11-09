import 'package:json_annotation/json_annotation.dart';

part 'get_all_ingredient_ids_and_names.g.dart';

@JsonSerializable()
class GetAllIngredientIdsAndNamesResponse {
  final int status;
  final String message;
  final IngredientData data;

  GetAllIngredientIdsAndNamesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllIngredientIdsAndNamesResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllIngredientIdsAndNamesResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAllIngredientIdsAndNamesResponseToJson(this);
}

@JsonSerializable()
class IngredientData {
  final List<Ingredient> ingredients;

  IngredientData({
    required this.ingredients,
  });

  factory IngredientData.fromJson(Map<String, dynamic> json) =>
      _$IngredientDataFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientDataToJson(this);
}

@JsonSerializable()
class Ingredient {
  @JsonKey(name: 'ingredient_id')
  final String ingredientId;
  @JsonKey(name: 'ingredient_eng_name')
  final String ingredientEngName;
  @JsonKey(name: 'ingredient_thai_name')
  final String ingredientThaiName;

  Ingredient({
    required this.ingredientId,
    required this.ingredientEngName,
    required this.ingredientThaiName,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

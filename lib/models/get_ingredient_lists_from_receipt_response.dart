import 'package:json_annotation/json_annotation.dart';

part 'get_ingredient_lists_from_receipt_response.g.dart';

@JsonSerializable()
class GetIngredientListsFromReceiptResponse {
  final int status;
  final String message;
  final IngredientListData data;

  GetIngredientListsFromReceiptResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetIngredientListsFromReceiptResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetIngredientListsFromReceiptResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetIngredientListsFromReceiptResponseToJson(this);
}

@JsonSerializable()
class IngredientListData {
  final List<Ingredient> ingredients;

  IngredientListData({
    required this.ingredients,
  });

  factory IngredientListData.fromJson(Map<String, dynamic> json) =>
      _$IngredientListDataFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientListDataToJson(this);
}

@JsonSerializable()
class Ingredient {
  @JsonKey(name: 'ingredient_name')
  final String ingredientName;
  final String quantity;
  final String price;

  Ingredient({
    required this.ingredientName,
    required this.quantity,
    required this.price,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

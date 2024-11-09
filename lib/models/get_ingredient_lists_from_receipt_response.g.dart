// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ingredient_lists_from_receipt_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIngredientListsFromReceiptResponse
    _$GetIngredientListsFromReceiptResponseFromJson(
            Map<String, dynamic> json) =>
        GetIngredientListsFromReceiptResponse(
          status: (json['status'] as num).toInt(),
          message: json['message'] as String,
          data:
              IngredientListData.fromJson(json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetIngredientListsFromReceiptResponseToJson(
        GetIngredientListsFromReceiptResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

IngredientListData _$IngredientListDataFromJson(Map<String, dynamic> json) =>
    IngredientListData(
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientListDataToJson(IngredientListData instance) =>
    <String, dynamic>{
      'ingredients': instance.ingredients,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      ingredientName: json['ingredient_name'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as String,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'ingredient_name': instance.ingredientName,
      'quantity': instance.quantity,
      'price': instance.price,
    };

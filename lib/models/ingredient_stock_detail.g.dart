// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_stock_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientStockDetailResponse _$IngredientStockDetailResponseFromJson(
        Map<String, dynamic> json) =>
    IngredientStockDetailResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: IngredientStockDetailData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IngredientStockDetailResponseToJson(
        IngredientStockDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

IngredientStockDetailData _$IngredientStockDetailDataFromJson(
        Map<String, dynamic> json) =>
    IngredientStockDetailData(
      ingredientEngName: json['ingredient_eng_name'] as String,
      ingredientThaiName: json['ingredient_thai_name'] as String,
      ingredientQuantity: json['ingredient_quantity'] as String,
      ingredientPrice: json['ingredient_price'] as String,
      ingredientBrand: json['ingredient_brand'] as String,
      ingredientSupplier: json['ingredient_supplier'] as String,
      ingredientStockUrl: json['ingredient_stock_url'] as String,
      dayBeforeExpire: json['day_before_expire'] as String,
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) =>
              IngredientStockDetailNote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientStockDetailDataToJson(
        IngredientStockDetailData instance) =>
    <String, dynamic>{
      'ingredient_eng_name': instance.ingredientEngName,
      'ingredient_thai_name': instance.ingredientThaiName,
      'ingredient_quantity': instance.ingredientQuantity,
      'ingredient_price': instance.ingredientPrice,
      'ingredient_brand': instance.ingredientBrand,
      'ingredient_supplier': instance.ingredientSupplier,
      'ingredient_stock_url': instance.ingredientStockUrl,
      'day_before_expire': instance.dayBeforeExpire,
      'notes': instance.notes,
    };

IngredientStockDetailNote _$IngredientStockDetailNoteFromJson(
        Map<String, dynamic> json) =>
    IngredientStockDetailNote(
      ingredientNoteId: json['ingredient_note_id'] as String,
      ingredientNote: json['ingredient_note'] as String,
      noteCreatedAt: json['note_created_at'] as String,
    );

Map<String, dynamic> _$IngredientStockDetailNoteToJson(
        IngredientStockDetailNote instance) =>
    <String, dynamic>{
      'ingredient_note_id': instance.ingredientNoteId,
      'ingredient_note': instance.ingredientNote,
      'note_created_at': instance.noteCreatedAt,
    };

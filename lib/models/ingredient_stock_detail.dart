import 'package:json_annotation/json_annotation.dart';

part 'ingredient_stock_detail.g.dart';

@JsonSerializable()
class IngredientStockDetailResponse {
  final int status;
  final String message;
  final IngredientStockDetailData data;

  IngredientStockDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory IngredientStockDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$IngredientStockDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientStockDetailResponseToJson(this);
}

@JsonSerializable()
class IngredientStockDetailData {
  @JsonKey(name: 'ingredient_eng_name')
  final String ingredientEngName;
  @JsonKey(name: 'ingredient_thai_name')
  final String ingredientThaiName;
  @JsonKey(name: 'ingredient_quantity')
  final String ingredientQuantity;
  @JsonKey(name: 'ingredient_price')
  final String ingredientPrice;
  @JsonKey(name: 'ingredient_brand')
  final String ingredientBrand;
  @JsonKey(name: 'ingredient_supplier')
  final String ingredientSupplier;
  @JsonKey(name: 'ingredient_stock_url')
  final String ingredientStockUrl;
  @JsonKey(name: 'day_before_expire')
  final String dayBeforeExpire;
  final List<IngredientStockDetailNote>? notes;

  IngredientStockDetailData({
    required this.ingredientEngName,
    required this.ingredientThaiName,
    required this.ingredientQuantity,
    required this.ingredientPrice,
    required this.ingredientBrand,
    required this.ingredientSupplier,
    required this.ingredientStockUrl,
    required this.dayBeforeExpire,
    required this.notes,
  });

  factory IngredientStockDetailData.fromJson(Map<String, dynamic> json) =>
      _$IngredientStockDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientStockDetailDataToJson(this);
}

@JsonSerializable()
class IngredientStockDetailNote {
  @JsonKey(name: 'ingredient_note_id')
  final String ingredientNoteId;
  @JsonKey(name: 'ingredient_note')
  final String ingredientNote;
  @JsonKey(name: 'note_created_at')
  final String noteCreatedAt;

  IngredientStockDetailNote({
    required this.ingredientNoteId,
    required this.ingredientNote,
    required this.noteCreatedAt,
  });

  factory IngredientStockDetailNote.fromJson(Map<String, dynamic> json) =>
      _$IngredientStockDetailNoteFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientStockDetailNoteToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'edit_stock_detail.g.dart';

@JsonSerializable()
class EditStockDetailResponse {
  final int status;
  final String message;
  final EditStockDetailData data;

  EditStockDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditStockDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EditStockDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EditStockDetailResponseToJson(this);
}

@JsonSerializable()
class EditStockDetailData {
  final String lst;
  @JsonKey(name: 'recipe_name')
  final String recipeName;
  @JsonKey(name: 'recipe_url')
  final String recipeUrl;
  @JsonKey(name: 'selling_price')
  final String sellingPrice;
  @JsonKey(name: 'stock_less_than')
  final String stockLessThan;
  @JsonKey(name: 'expiration_date')
  final String expirationDate;

  EditStockDetailData({
    required this.lst,
    required this.recipeName,
    required this.recipeUrl,
    required this.sellingPrice,
    required this.stockLessThan,
    required this.expirationDate,
  });

  factory EditStockDetailData.fromJson(Map<String, dynamic> json) =>
      _$EditStockDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$EditStockDetailDataToJson(this);
}

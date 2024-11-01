import 'package:json_annotation/json_annotation.dart';

part 'stock_order_page.g.dart';

@JsonSerializable()
class StockOrderPageResponse {
  final int status;
  final String message;
  final StockOrderPageData data;

  StockOrderPageResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StockOrderPageResponse.fromJson(Map<String, dynamic> json) =>
      _$StockOrderPageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockOrderPageResponseToJson(this);
}

@JsonSerializable()
class StockOrderPageData {
  @JsonKey(name: 'order_stocks')
  final List<StockOrderItemData> stocks;

  StockOrderPageData({
    required this.stocks,
  });

  factory StockOrderPageData.fromJson(Map<String, dynamic> json) =>
      _$StockOrderPageDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockOrderPageDataToJson(this);
}

@JsonSerializable()
class StockOrderItemData {
  @JsonKey(name: 'recipe_id')
  final String recipeID;
  @JsonKey(name: 'recipe_name')
  final String recipeName;
  final int quantity;
  @JsonKey(name: 'sell_by_date')
  final String sellByDate;
  @JsonKey(name: 'recipe_url')
  final String recipeUrl;
  @JsonKey(name: 'selling_price')
  final double sellingPrice;
  final double profit;

  StockOrderItemData(this.recipeID, this.recipeName, this.sellByDate,
      this.recipeUrl, this.profit, this.quantity, this.sellingPrice);

  StockOrderItemData copyWith({int? quantity}) {
    return StockOrderItemData(
      recipeID,
      recipeName,
      sellByDate,
      recipeUrl,
      profit,
      quantity ?? this.quantity, 
      sellingPrice,
    );
  }

  factory StockOrderItemData.fromJson(Map<String, dynamic> json) =>
      _$StockOrderItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockOrderItemDataToJson(this);
}

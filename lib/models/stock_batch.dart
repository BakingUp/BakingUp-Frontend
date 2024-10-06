import 'package:json_annotation/json_annotation.dart';

part 'stock_batch.g.dart';

@JsonSerializable()
class StockBatchResponse {
  final int status;
  final String message;
  final StockBatchData data;

  StockBatchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StockBatchResponse.fromJson(Map<String, dynamic> json) =>
      _$StockBatchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockBatchResponseToJson(this);
}

@JsonSerializable()
class StockBatchData {
  @JsonKey(name: 'stock_detail_id')
  final String stockDetailId;
  @JsonKey(name: 'recipe_name')
  final String recipeName;
  @JsonKey(name: 'recipe_url')
  final String recipeUrl;
  final int quantity;
  @JsonKey(name: 'sell_by_date')
  final String sellByDate;
  final String note;
  @JsonKey(name: 'note_created_at')
  final String noteCreatedAt;

  StockBatchData({
    required this.stockDetailId,
    required this.recipeName,
    required this.recipeUrl,
    required this.quantity,
    required this.sellByDate,
    required this.note,
    required this.noteCreatedAt,
  });

  factory StockBatchData.fromJson(Map<String, dynamic> json) =>
      _$StockBatchDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockBatchDataToJson(this);
}

import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class StockListResponse {
  final int status;
  final String message;
  final StockListData data;

  StockListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StockListResponse.fromJson(Map<String, dynamic> json) =>
      _$StockListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockListResponseToJson(this);
}

@JsonSerializable()
class StockListData {
  final List<StockItemData> stocks;

  StockListData({
    required this.stocks,
  });

  factory StockListData.fromJson(Map<String, dynamic> json) =>
      _$StockListDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockListDataToJson(this);
}

@JsonSerializable()
class StockItemData {
  @JsonKey(name: 'stock_id')
  final String stockID;
  @JsonKey(name: 'stock_name')
  final String stockName;
  @JsonKey(name: 'stock_url')
  final String stockUrl;
  final int quantity;
  final int lst;
  @JsonKey(name: 'selling_price')
  final double sellingPrice;
  @JsonKey(name: 'lst_status')
  final LSTStatus lstStatus;

  StockItemData({
    required this.stockID,
    required this.stockName,
    required this.stockUrl,
    required this.quantity,
    required this.lst,
    required this.sellingPrice,
    required this.lstStatus,
  });

  factory StockItemData.fromJson(Map<String, dynamic> json) =>
      _$StockItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockItemDataToJson(this);
}

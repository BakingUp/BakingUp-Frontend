import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_detail.g.dart';

@JsonSerializable()
class StockDetailResponse {
  final int status;
  final String message;
  final StockDetailData data;

  StockDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StockDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StockDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StockDetailResponseToJson(this);
}

@JsonSerializable()
class StockDetailData {
  @JsonKey(name: 'stock_name')
  final String stockName;
  @JsonKey(name: 'stock_url')
  final List<String> stockUrl;
  final int quantity;
  final int lst;
  @JsonKey(name: 'selling_price')
  final double sellingPrice;
  @JsonKey(name: 'stock_less_than')
  final int stockLessThan;
  @JsonKey(name: 'stock_details')
  final List<StockDetail> stockDetails;

  StockDetailData({
    required this.stockName,
    required this.stockUrl,
    required this.quantity,
    required this.lst,
    required this.sellingPrice,
    required this.stockLessThan,
    required this.stockDetails,
  });

  factory StockDetailData.fromJson(Map<String, dynamic> json) =>
      _$StockDetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockDetailDataToJson(this);
}

@JsonSerializable()
class StockDetail {
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'lst_status')
  final LSTStatus lstStatus;
  final int quantity;
  @JsonKey(name: 'sell_by_date')
  final String sellByDate;

  StockDetail({
    required this.createdAt,
    required this.lstStatus,
    required this.quantity,
    required this.sellByDate,
  });

  factory StockDetail.fromJson(Map<String, dynamic> json) =>
      _$StockDetailFromJson(json);
  Map<String, dynamic> toJson() => _$StockDetailToJson(this);
}

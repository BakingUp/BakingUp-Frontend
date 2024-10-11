import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class UnreadNotificationResponse {
  final int status;
  final String message;
  final UnreadNotificationData data;

  UnreadNotificationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UnreadNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadNotificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UnreadNotificationResponseToJson(this);
}

@JsonSerializable()
class UnreadNotificationData {
  @JsonKey(name: 'unread_noti_amount')
  final int unreadNotiAmount;

  UnreadNotificationData({
    required this.unreadNotiAmount,
  });

  factory UnreadNotificationData.fromJson(Map<String, dynamic> json) =>
      _$UnreadNotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$UnreadNotificationDataToJson(this);
}

@JsonSerializable()
class DashboardChartResponse {
  final int status;
  final String message;
  final DashboardChartData data;

  DashboardChartResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DashboardChartResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardChartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardChartResponseToJson(this);
}

@JsonSerializable()
class DashboardChartData {
  @JsonKey(name: 'cost_revenue')
  final List<CostRevenueData> costRevenue;
  @JsonKey(name: 'net_profit')
  final List<NetProfitData> netProfit;
  @JsonKey(name: 'profit_threshold')
  final List<ProfitThreshold> profitThreshold;

  DashboardChartData(
      {required this.costRevenue,
      required this.netProfit,
      required this.profitThreshold});

  factory DashboardChartData.fromJson(Map<String, dynamic> json) =>
      _$DashboardChartDataFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardChartDataToJson(this);
}

@JsonSerializable()
class CostRevenueData {
  final String month;
  final double revenue;
  final double cost;
  @JsonKey(name: 'net_profit')
  final double netProfit;

  CostRevenueData(
      {required this.month,
      required this.revenue,
      required this.cost,
      required this.netProfit});

  factory CostRevenueData.fromJson(Map<String, dynamic> json) =>
      _$CostRevenueDataFromJson(json);
  Map<String, dynamic> toJson() => _$CostRevenueDataToJson(this);
}

@JsonSerializable()
class NetProfitData {
  final String month;
  final double profit;

  NetProfitData({required this.month, required this.profit});

  factory NetProfitData.fromJson(Map<String, dynamic> json) =>
      _$NetProfitDataFromJson(json);
  Map<String, dynamic> toJson() => _$NetProfitDataToJson(this);
}

@JsonSerializable()
class ProfitThreshold {
  final String name;
  final double threshold;

  ProfitThreshold({
    required this.name,
    required this.threshold,
  });

  factory ProfitThreshold.fromJson(Map<String, dynamic> json) =>
      _$ProfitThresholdFromJson(json);
  Map<String, dynamic> toJson() => _$ProfitThresholdToJson(this);
}

@JsonSerializable()
class TopProductResponse {
  final int status;
  final String message;
  final TopProductData data;

  TopProductResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TopProductResponse.fromJson(Map<String, dynamic> json) =>
      _$TopProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TopProductResponseToJson(this);
}

@JsonSerializable()
class TopProductData {
  final List<TopProductItem> products;

  TopProductData({
    required this.products,
  });

  factory TopProductData.fromJson(Map<String, dynamic> json) =>
      _$TopProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$TopProductDataToJson(this);
}

@JsonSerializable()
class TopProductItem {
  final String name;
  final String url;
  final String detail;

  TopProductItem({required this.name, required this.url, required this.detail});

  factory TopProductItem.fromJson(Map<String, dynamic> json) =>
      _$TopProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$TopProductItemToJson(this);
}

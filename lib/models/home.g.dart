// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnreadNotificationResponse _$UnreadNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    UnreadNotificationResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data:
          UnreadNotificationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnreadNotificationResponseToJson(
        UnreadNotificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

UnreadNotificationData _$UnreadNotificationDataFromJson(
        Map<String, dynamic> json) =>
    UnreadNotificationData(
      unreadNotiAmount: (json['unread_noti_amount'] as num).toInt(),
    );

Map<String, dynamic> _$UnreadNotificationDataToJson(
        UnreadNotificationData instance) =>
    <String, dynamic>{
      'unread_noti_amount': instance.unreadNotiAmount,
    };

DashboardChartResponse _$DashboardChartResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardChartResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: DashboardChartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardChartResponseToJson(
        DashboardChartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

DashboardChartData _$DashboardChartDataFromJson(Map<String, dynamic> json) =>
    DashboardChartData(
      costRevenue: (json['cost_revenue'] as List<dynamic>)
          .map((e) => CostRevenueData.fromJson(e as Map<String, dynamic>))
          .toList(),
      netProfit: (json['net_profit'] as List<dynamic>)
          .map((e) => NetProfitData.fromJson(e as Map<String, dynamic>))
          .toList(),
      profitThreshold: (json['profit_threshold'] as List<dynamic>)
          .map((e) => ProfitThreshold.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardChartDataToJson(DashboardChartData instance) =>
    <String, dynamic>{
      'cost_revenue': instance.costRevenue,
      'net_profit': instance.netProfit,
      'profit_threshold': instance.profitThreshold,
    };

CostRevenueData _$CostRevenueDataFromJson(Map<String, dynamic> json) =>
    CostRevenueData(
      month: json['month'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      netProfit: (json['net_profit'] as num).toDouble(),
    );

Map<String, dynamic> _$CostRevenueDataToJson(CostRevenueData instance) =>
    <String, dynamic>{
      'month': instance.month,
      'revenue': instance.revenue,
      'cost': instance.cost,
      'net_profit': instance.netProfit,
    };

NetProfitData _$NetProfitDataFromJson(Map<String, dynamic> json) =>
    NetProfitData(
      month: json['month'] as String,
      profit: (json['profit'] as num).toDouble(),
    );

Map<String, dynamic> _$NetProfitDataToJson(NetProfitData instance) =>
    <String, dynamic>{
      'month': instance.month,
      'profit': instance.profit,
    };

ProfitThreshold _$ProfitThresholdFromJson(Map<String, dynamic> json) =>
    ProfitThreshold(
      name: json['name'] as String,
      threshold: (json['threshold'] as num).toDouble(),
    );

Map<String, dynamic> _$ProfitThresholdToJson(ProfitThreshold instance) =>
    <String, dynamic>{
      'name': instance.name,
      'threshold': instance.threshold,
    };

TopProductResponse _$TopProductResponseFromJson(Map<String, dynamic> json) =>
    TopProductResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: TopProductData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopProductResponseToJson(TopProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

TopProductData _$TopProductDataFromJson(Map<String, dynamic> json) =>
    TopProductData(
      products: (json['products'] as List<dynamic>)
          .map((e) => TopProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopProductDataToJson(TopProductData instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

TopProductItem _$TopProductItemFromJson(Map<String, dynamic> json) =>
    TopProductItem(
      name: json['name'] as String,
      url: json['url'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$TopProductItemToJson(TopProductItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'detail': instance.detail,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DashboardResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      json['statusCode'] as num?,
      json['message'] as String?,
      (json['sales'] as List<dynamic>?)
          ?.map((e) => Dashboard.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['uniqueOrders'] as List<dynamic>?)
          ?.map((e) => Dashboard.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalOrder'] as num?,
      json['totalIncome'] as num?,
      json['orderIncrease'] as num?,
      json['incomeIncrease'] as num?,
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'sales': instance.sales,
      'uniqueOrders': instance.uniqueOrders,
      'totalOrder': instance.totalOrder,
      'totalIncome': instance.totalIncome,
      'orderIncrease': instance.orderIncrease,
      'incomeIncrease': instance.incomeIncrease,
    };

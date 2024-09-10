// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderMenuResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMenuResponse _$OrderMenuResponseFromJson(Map<String, dynamic> json) =>
    OrderMenuResponse(
      json['statusCode'] as num?,
      json['message'] as String?,
      (json['orderStat'] as List<dynamic>?)
          ?.map((e) => OrderMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderMenuResponseToJson(OrderMenuResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'orderStat': instance.orderStat,
    };

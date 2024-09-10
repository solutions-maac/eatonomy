// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MenuResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuResponse _$MenuResponseFromJson(Map<String, dynamic> json) => MenuResponse(
      json['message'] as String?,
      json['statusCode'] as num?,
      (json['feeds'] as List<dynamic>?)
          ?.map((e) => Feed.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuResponseToJson(MenuResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'feeds': instance.feeds,
    };

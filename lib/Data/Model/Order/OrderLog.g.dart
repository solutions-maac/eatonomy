// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLog _$OrderLogFromJson(Map<String, dynamic> json) => OrderLog(
      json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      json['value'] as String?,
      json['datetime'] as String?,
      json['note'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$OrderLogToJson(OrderLog instance) => <String, dynamic>{
      'createdBy': instance.createdBy,
      'value': instance.value,
      'datetime': instance.datetime,
      'note': instance.note,
      'image': instance.image,
    };

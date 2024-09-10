// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      json['message'] as String?,
      json['totalPages'] as num?,
      json['statusCode'] as num?,
      json['status'] as num?,
      json['totalElements'] as num?,
      json['numberOfElements'] as num?,
      json['currentPageNumber'] as num?,
      json['first'] as bool?,
      json['last'] as bool?,
      (json['notifications'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalPages': instance.totalPages,
      'statusCode': instance.statusCode,
      'status': instance.status,
      'totalElements': instance.totalElements,
      'numberOfElements': instance.numberOfElements,
      'currentPageNumber': instance.currentPageNumber,
      'first': instance.first,
      'last': instance.last,
      'notifications': instance.notifications,
    };

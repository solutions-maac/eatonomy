// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtpResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) => OtpResponse(
      json['success'] as bool?,
      json['status'] as num?,
      json['statusCode'] as num?,
      json['message'] as String?,
      json['error'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$OtpResponseToJson(OtpResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'error': instance.error,
      'url': instance.url,
    };

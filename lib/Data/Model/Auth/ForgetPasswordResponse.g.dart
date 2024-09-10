// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ForgetPasswordResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordResponse _$ForgetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordResponse(
      json['success'] as bool?,
      json['message'] as String?,
      json['data'] as bool?,
      json['error'] as String?,
    )..errors = json['errors'] == null
        ? null
        : ErrorModel.fromJson(json['errors'] as Map<String, dynamic>);

Map<String, dynamic> _$ForgetPasswordResponseToJson(
        ForgetPasswordResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
      'errors': instance.errors,
    };

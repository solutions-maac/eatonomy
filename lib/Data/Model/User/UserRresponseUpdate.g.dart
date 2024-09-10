// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserRresponseUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRresponseUpdate _$UserRresponseUpdateFromJson(Map<String, dynamic> json) =>
    UserRresponseUpdate(
      json['success'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRresponseUpdateToJson(
        UserRresponseUpdate instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataBean _$DataBeanFromJson(Map<String, dynamic> json) => DataBean(
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['user_profile'] == null
          ? null
          : User.fromJson(json['user_profile'] as Map<String, dynamic>),
      json['token'] as String?,
      json['role'] as String?,
    );

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'user': instance.user,
      'user_profile': instance.user_profile,
      'token': instance.token,
      'role': instance.role,
    };

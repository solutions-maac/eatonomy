// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ErrorModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
      (json['mobile'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['password'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['password_confirmation'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.password_confirmation,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChefRresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChefRresponse _$ChefRresponseFromJson(Map<String, dynamic> json) =>
    ChefRresponse(
      json['statusCode'] as num?,
      json['message'] as String?,
      (json['chefAdmins'] as List<dynamic>?)
          ?.map((e) => ChefData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChefRresponseToJson(ChefRresponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'chefAdmins': instance.chefAdmins,
    };

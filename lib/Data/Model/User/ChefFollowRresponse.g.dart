// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChefFollowRresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChefFollowRresponse _$ChefFollowRresponseFromJson(Map<String, dynamic> json) =>
    ChefFollowRresponse(
      json['statusCode'] as num?,
      json['message'] as String?,
      (json['follows'] as List<dynamic>?)
          ?.map((e) => ChefData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChefFollowRresponseToJson(
        ChefFollowRresponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'follows': instance.follows,
    };

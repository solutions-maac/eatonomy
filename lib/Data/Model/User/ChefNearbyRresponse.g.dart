// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChefNearbyRresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChefNearbyRresponse _$ChefNearbyRresponseFromJson(Map<String, dynamic> json) =>
    ChefNearbyRresponse(
      json['statusCode'] as num?,
      json['message'] as String?,
      (json['chefs'] as List<dynamic>?)
          ?.map((e) => Chef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChefNearbyRresponseToJson(
        ChefNearbyRresponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'chefs': instance.chefs,
    };

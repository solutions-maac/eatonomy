// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WishResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishResponse _$WishResponseFromJson(Map<String, dynamic> json) => WishResponse(
      json['message'] as String?,
      json['statusCode'] as num?,
      (json['follows'] as List<dynamic>?)
          ?.map((e) => Feed.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WishResponseToJson(WishResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'follows': instance.follows,
    };

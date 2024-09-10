// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MenuSearchResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuSearchResponse _$MenuSearchResponseFromJson(Map<String, dynamic> json) =>
    MenuSearchResponse(
      json['message'] as String?,
      json['statusCode'] as num?,
      (json['menus'] as List<dynamic>?)
          ?.map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuSearchResponseToJson(MenuSearchResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'menus': instance.menus,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChefDetailsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChefDetailsResponse _$ChefDetailsResponseFromJson(Map<String, dynamic> json) =>
    ChefDetailsResponse(
      json['message'] as String?,
      json['statusCode'] as num?,
      json['isFollowed'] as bool?,
      json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      (json['menus'] as List<dynamic>?)
          ?.map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['reviewStats'] as List<dynamic>?)
          ?.map((e) => StarReview.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalWeeklyOrder'] as num?,
      json['totalPartyOrder'] as num?,
      (json['compliments'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChefDetailsResponseToJson(
        ChefDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'isFollowed': instance.isFollowed,
      'chef': instance.chef,
      'user': instance.user,
      'menus': instance.menus,
      'reviews': instance.reviews,
      'reviewStats': instance.reviewStats,
      'totalWeeklyOrder': instance.totalWeeklyOrder,
      'totalPartyOrder': instance.totalPartyOrder,
      'compliments': instance.compliments,
    };

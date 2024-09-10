// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map<String, dynamic> json) => Feed(
      json['id'] as String?,
      json['chefId'] as String?,
      json['userId'] as String?,
      json['createdAt'] as String?,
      json['type'] as String?,
      json['description'] as String?,
      json['typeId'] as String?,
      json['price'] as num?,
      json['alreadyInWishList'] as bool?,
      json['isActive'] as bool?,
      json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'id': instance.id,
      'chefId': instance.chefId,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'type': instance.type,
      'description': instance.description,
      'typeId': instance.typeId,
      'price': instance.price,
      'alreadyInWishList': instance.alreadyInWishList,
      'isActive': instance.isActive,
      'menu': instance.menu,
      'images': instance.images,
      'chef': instance.chef,
    };

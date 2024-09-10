// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as String?,
      json['chefId'] as String?,
      json['orderId'] as String?,
      json['createdAt'] as String?,
      json['comment'] as String?,
      json['updatedAt'] as String?,
      json['text'] as String?,
      json['userInfo'] == null
          ? null
          : User.fromJson(json['userInfo'] as Map<String, dynamic>),
      json['rating'] as num?,
      json['count'] as num?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'chefId': instance.chefId,
      'orderId': instance.orderId,
      'createdAt': instance.createdAt,
      'comment': instance.comment,
      'updatedAt': instance.updatedAt,
      'text': instance.text,
      'userInfo': instance.userInfo,
      'rating': instance.rating,
      'count': instance.count,
    };

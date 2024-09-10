// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      json['id'] as String?,
      json['userId'] as String?,
      json['title'] as String?,
      json['message'] as String?,
      json['image'] as String?,
      json['type'] as String?,
      json['typeId'] as String?,
      json['createdAt'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'message': instance.message,
      'image': instance.image,
      'type': instance.type,
      'typeId': instance.typeId,
      'createdAt': instance.createdAt,
      'status': instance.status,
    };

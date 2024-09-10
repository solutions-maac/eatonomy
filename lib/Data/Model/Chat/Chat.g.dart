// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      json['id'] as String?,
      json['orderId'] as String?,
      json['message'] as String?,
      json['type'] as String?,
      json['createdAt'] as String?,
      json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'message': instance.message,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'sender': instance.sender,
    };

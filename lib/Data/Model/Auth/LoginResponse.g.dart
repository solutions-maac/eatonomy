// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['success'] as bool?,
      json['statusCode'] as num?,
      json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
      json['message'] as String?,
      json['error'],
      json['token'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['mobileNumber'] as String?,
      json['profilePicture'] as String?,
      json['chefId'] as String?,
      json['type'] as String?,
      json['rating'] as num?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'chef': instance.chef,
      'message': instance.message,
      'error': instance.error,
      'token': instance.token,
      'name': instance.name,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'profilePicture': instance.profilePicture,
      'chefId': instance.chefId,
      'type': instance.type,
      'rating': instance.rating,
    };

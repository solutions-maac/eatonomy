// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String?,
      json['verification_code'] as String?,
      json['mobile'] as String?,
      json['mobileNumber'] as String?,
      json['name'] as String?,
      json['profilePicture'] as String?,
      json['email'] as String?,
      json['address'] as String?,
      json['city'] as String?,
      json['zipCode'] as String?,
      json['email_verified_at'] as String?,
      json['two_factor_secret'] as String?,
      json['google_id'] as String?,
      json['facebook_id'] as String?,
      json['note'] as String?,
      json['status'] as num?,
      json['rating'] as num?,
      json['notification_status'] as num?,
      json['role'] as String?,
      json['photo'] as String?,
      json['signature'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      json['language'] as String?,
      json['bio'] as String?,
      json['social'] as String?,
      json['created_at'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'verification_code': instance.verification_code,
      'mobile': instance.mobile,
      'mobileNumber': instance.mobileNumber,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'email': instance.email,
      'address': instance.address,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'email_verified_at': instance.email_verified_at,
      'two_factor_secret': instance.two_factor_secret,
      'google_id': instance.google_id,
      'facebook_id': instance.facebook_id,
      'note': instance.note,
      'status': instance.status,
      'rating': instance.rating,
      'notification_status': instance.notification_status,
      'role': instance.role,
      'photo': instance.photo,
      'signature': instance.signature,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'language': instance.language,
      'bio': instance.bio,
      'social': instance.social,
      'created_at': instance.created_at,
    };

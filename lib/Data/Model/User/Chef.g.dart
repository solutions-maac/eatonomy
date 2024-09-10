// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chef.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chef _$ChefFromJson(Map<String, dynamic> json) => Chef(
      json['id'] as String?,
      json['userId'] as String?,
      json['mobileNumber'] as String?,
      json['name'] as String?,
      json['profilePicture'] as String?,
      json['paymentInstruction'] as String?,
      json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      json['zipCode'] as String?,
      json['city'] as String?,
      json['address'] as String?,
      json['email'] as String?,
      json['banner'] as String?,
      json['rating'] as num?,
      json['experience'] as num?,
      json['about'] as String?,
      json['referralCode'],
      json['user'] == null
          ? null
          : ChefUser.fromJson(json['user'] as Map<String, dynamic>),
      json['isFollowed'] as bool?,
      json['isHotDeal'] as bool?,
      json['numberOfItem'] as num?,
    );

Map<String, dynamic> _$ChefToJson(Chef instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'mobileNumber': instance.mobileNumber,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'paymentInstruction': instance.paymentInstruction,
      'location': instance.location,
      'zipCode': instance.zipCode,
      'city': instance.city,
      'address': instance.address,
      'email': instance.email,
      'banner': instance.banner,
      'rating': instance.rating,
      'experience': instance.experience,
      'about': instance.about,
      'referralCode': instance.referralCode,
      'user': instance.user,
      'isFollowed': instance.isFollowed,
      'isHotDeal': instance.isHotDeal,
      'numberOfItem': instance.numberOfItem,
    };

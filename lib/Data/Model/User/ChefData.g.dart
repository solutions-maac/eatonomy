// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChefData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChefData _$ChefDataFromJson(Map<String, dynamic> json) => ChefData(
      json['id'] as String?,
      json['chefId'] as String?,
      json['userId'] as String?,
      json['status'] as String?,
      json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChefDataToJson(ChefData instance) => <String, dynamic>{
      'id': instance.id,
      'chefId': instance.chefId,
      'userId': instance.userId,
      'status': instance.status,
      'chef': instance.chef,
    };

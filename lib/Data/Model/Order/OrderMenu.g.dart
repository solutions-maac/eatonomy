// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderMenu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMenu _$OrderMenuFromJson(Map<String, dynamic> json) => OrderMenu(
      json['menuId'] as String?,
      json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
      json['count'] as num?,
    );

Map<String, dynamic> _$OrderMenuToJson(OrderMenu instance) => <String, dynamic>{
      'menuId': instance.menuId,
      'menu': instance.menu,
      'count': instance.count,
    };

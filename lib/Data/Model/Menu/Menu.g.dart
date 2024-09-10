// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      json['id'] as String?,
      json['price'] as num?,
      json['title'] as String?,
      json['type'] as String?,
      json['orderTakingInstruction'] as String?,
      json['deliveryInstruction'] as String?,
      json['chefId'] as String?,
      json['deliveryDay'] as String?,
      json['deliveryFrom'] as num?,
      json['deliveryTo'] as num?,
      json['discountedPrice'] as num?,
      json['orderTakingBeforeDelivery'] as num?,
      json['createdAt'] as String?,
      json['cuisine'] as String?,
      json['isPickUpAvailable'] as bool?,
      json['isHotDeal'] as bool?,
      json['alreadyInWishList'] as bool?,
      json['isDeliveryAvailable'] as bool?,
      (json['menus'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'title': instance.title,
      'type': instance.type,
      'orderTakingInstruction': instance.orderTakingInstruction,
      'deliveryInstruction': instance.deliveryInstruction,
      'chefId': instance.chefId,
      'deliveryDay': instance.deliveryDay,
      'deliveryFrom': instance.deliveryFrom,
      'deliveryTo': instance.deliveryTo,
      'discountedPrice': instance.discountedPrice,
      'orderTakingBeforeDelivery': instance.orderTakingBeforeDelivery,
      'createdAt': instance.createdAt,
      'cuisine': instance.cuisine,
      'isPickUpAvailable': instance.isPickUpAvailable,
      'isHotDeal': instance.isHotDeal,
      'alreadyInWishList': instance.alreadyInWishList,
      'isDeliveryAvailable': instance.isDeliveryAvailable,
      'menus': instance.menus,
      'images': instance.images,
      'chef': instance.chef,
    };

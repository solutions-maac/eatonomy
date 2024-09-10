// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['id'] as String?,
      json['orderId'] as String?,
      json['userId'] as String?,
      json['chefId'] as String?,
      json['menuId'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
      json['menu'] == null
          ? null
          : Menu.fromJson(json['menu'] as Map<String, dynamic>),
      json['quantity'] as num?,
      json['price'] as num?,
      json['deliveryCharge'] as num?,
      json['deliveryAddress'] as String?,
      json['deliveryOption'] as String?,
      json['paymentStatus'] as String?,
      json['paymentNoteByCustomer'] as String?,
      json['paymentProofByCustomer'] as String?,
      json['status'] as String?,
      json['isPaymentConfirmed'] as bool?,
      json['isAcceptedByChef'] as bool?,
      json['isReadyForPickUp'] as bool?,
      json['alreadyReviewed'] as bool?,
      json['alreadyReviewedByChef'] as bool?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
      json['customerStatus'] as String?,
      json['paymentRequested'] as bool?,
      json['deliveryDay'] as String?,
      json['deliveryTime'] as String?,
      json['deliveryFrom'],
      json['deliveryTo'],
      json['customerReview'] == null
          ? null
          : Review.fromJson(json['customerReview'] as Map<String, dynamic>),
      json['chefReview'] == null
          ? null
          : Review.fromJson(json['chefReview'] as Map<String, dynamic>),
      (json['dateAndTimeLogs'] as List<dynamic>?)
          ?.map((e) => OrderLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['paymentLogs'] as List<dynamic>?)
          ?.map((e) => OrderLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['deliveryLogs'] as List<dynamic>?)
          ?.map((e) => OrderLog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'userId': instance.userId,
      'chefId': instance.chefId,
      'menuId': instance.menuId,
      'user': instance.user,
      'chef': instance.chef,
      'menu': instance.menu,
      'quantity': instance.quantity,
      'price': instance.price,
      'deliveryCharge': instance.deliveryCharge,
      'deliveryAddress': instance.deliveryAddress,
      'deliveryOption': instance.deliveryOption,
      'paymentStatus': instance.paymentStatus,
      'paymentNoteByCustomer': instance.paymentNoteByCustomer,
      'paymentProofByCustomer': instance.paymentProofByCustomer,
      'status': instance.status,
      'isPaymentConfirmed': instance.isPaymentConfirmed,
      'isAcceptedByChef': instance.isAcceptedByChef,
      'isReadyForPickUp': instance.isReadyForPickUp,
      'alreadyReviewed': instance.alreadyReviewed,
      'alreadyReviewedByChef': instance.alreadyReviewedByChef,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'customerStatus': instance.customerStatus,
      'paymentRequested': instance.paymentRequested,
      'deliveryDay': instance.deliveryDay,
      'deliveryTime': instance.deliveryTime,
      'deliveryFrom': instance.deliveryFrom,
      'deliveryTo': instance.deliveryTo,
      'customerReview': instance.customerReview,
      'chefReview': instance.chefReview,
      'dateAndTimeLogs': instance.dateAndTimeLogs,
      'paymentLogs': instance.paymentLogs,
      'deliveryLogs': instance.deliveryLogs,
    };

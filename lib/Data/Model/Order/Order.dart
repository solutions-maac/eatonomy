// ignore_for_file: file_names

import 'package:eatonomy/Data/Model/Order/OrderLog.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Menu/Menu.dart';
import '../Review/Review.dart';
import '../User/Chef.dart';
import '../User/User.dart';



part 'Order.g.dart';

@JsonSerializable()
class Order{

  String? id;
  String? orderId;
  String? userId;
  String? chefId;
  String? menuId;
  User? user;
  Chef? chef;
  Menu? menu;
  num? quantity;
  num? price;
  num? deliveryCharge;
  String? deliveryAddress;
  String? deliveryOption;
  String? paymentStatus;
  String? paymentNoteByCustomer;
  String? paymentProofByCustomer;
  String? status;
  bool? isPaymentConfirmed;
  bool? isAcceptedByChef;
  bool? isReadyForPickUp;
  bool? alreadyReviewed;
  bool? alreadyReviewedByChef;
  String? createdAt;
  String? updatedAt;
  String? customerStatus;
  bool? paymentRequested;
  String? deliveryDay;
  String? deliveryTime;
  dynamic deliveryFrom;
  dynamic deliveryTo;
  Review? customerReview;
  Review? chefReview;
 List<OrderLog>?dateAndTimeLogs;
 List<OrderLog>?paymentLogs;
 List<OrderLog>?deliveryLogs;


  Order(
      this.id,
      this.orderId,
      this.userId,
      this.chefId,
      this.menuId,
      this.user,
      this.chef,
      this.menu,
      this.quantity,
      this.price,
      this.deliveryCharge,
      this.deliveryAddress,
      this.deliveryOption,
      this.paymentStatus,
      this.paymentNoteByCustomer,
      this.paymentProofByCustomer,
      this.status,
      this.isPaymentConfirmed,
      this.isAcceptedByChef,
      this.isReadyForPickUp,
      this.alreadyReviewed,
      this.alreadyReviewedByChef,
      this.createdAt,
      this.updatedAt,
      this.customerStatus,
      this.paymentRequested,
      this.deliveryDay,
      this.deliveryTime,
      this.deliveryFrom,
      this.deliveryTo,
      this.customerReview,
      this.chefReview,
      this.dateAndTimeLogs,
      this.paymentLogs,
      this.deliveryLogs);

  factory Order.fromJson(Map<String,dynamic>json)=>
      _$OrderFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderToJson(this);
}
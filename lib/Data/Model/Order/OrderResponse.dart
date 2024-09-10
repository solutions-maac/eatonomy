// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Order.dart';

part 'OrderResponse.g.dart';

@JsonSerializable()
class OrderResponse{

  num? statusCode;
  String? message;
  List<Order>?orders;

  OrderResponse(this.statusCode, this.message, this.orders);

  factory OrderResponse.fromJson(Map<String,dynamic>json)=>
      _$OrderResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderResponseToJson(this);
}
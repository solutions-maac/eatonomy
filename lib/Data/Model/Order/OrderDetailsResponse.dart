// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Order.dart';

part 'OrderDetailsResponse.g.dart';

@JsonSerializable()
class OrderDetailsResponse{

  num? statusCode;
  String? message;
  Order?order;

  OrderDetailsResponse(this.statusCode, this.message, this.order);

  factory OrderDetailsResponse.fromJson(Map<String,dynamic>json)=>
      _$OrderDetailsResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderDetailsResponseToJson(this);
}
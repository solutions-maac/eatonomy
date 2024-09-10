// ignore_for_file: file_names

import 'package:eatonomy/Data/Model/Order/OrderMenu.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Menu/Menu.dart';
import '../Review/Review.dart';
import '../User/Chef.dart';
import '../User/User.dart';



part 'OrderMenuResponse.g.dart';

@JsonSerializable()
class OrderMenuResponse{

  num? statusCode;
  String? message;
  List<OrderMenu>?orderStat;


  OrderMenuResponse(this.statusCode, this.message, this.orderStat);

  factory OrderMenuResponse.fromJson(Map<String,dynamic>json)=>
      _$OrderMenuResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderMenuResponseToJson(this);
}
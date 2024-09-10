// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../Menu/Menu.dart';
import '../Review/Review.dart';
import '../User/Chef.dart';
import '../User/User.dart';



part 'OrderLog.g.dart';

@JsonSerializable()
class OrderLog{

  User?createdBy;
  String? value;
  String? datetime;
  String? note;
  String? image;


  OrderLog(this.createdBy, this.value, this.datetime, this.note, this.image);

  factory OrderLog.fromJson(Map<String,dynamic>json)=>
      _$OrderLogFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderLogToJson(this);
}
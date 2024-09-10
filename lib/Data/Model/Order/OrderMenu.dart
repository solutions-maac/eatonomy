// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../Menu/Menu.dart';
import '../Review/Review.dart';
import '../User/Chef.dart';
import '../User/User.dart';



part 'OrderMenu.g.dart';

@JsonSerializable()
class OrderMenu{

  String? menuId;
  Menu? menu;
  num?count;


  OrderMenu(this.menuId, this.menu, this.count);

  factory OrderMenu.fromJson(Map<String,dynamic>json)=>
      _$OrderMenuFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderMenuToJson(this);
}
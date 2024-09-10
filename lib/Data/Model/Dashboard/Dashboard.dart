// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
import '../User/User.dart';
part 'Dashboard.g.dart';

@JsonSerializable()
class Dashboard{

  String? date;
  num? price;
  num? numberOfOrder;


  Dashboard(this.date, this.price, this.numberOfOrder);

  factory Dashboard.fromJson(Map<String,dynamic>json)=>
      _$DashboardFromJson(json);
  Map<String,dynamic>toJson()=>_$DashboardToJson(this);
}
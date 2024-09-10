// ignore_for_file: file_names

import 'package:eatonomy/Data/Model/Dashboard/Dashboard.dart';
import 'package:json_annotation/json_annotation.dart';
import '../User/User.dart';
part 'DashboardResponse.g.dart';

@JsonSerializable()
class DashboardResponse{

  num? statusCode;
  String? message;
  List<Dashboard>?sales;
  List<Dashboard>?uniqueOrders;
  num?totalOrder;
  num?totalIncome;
  num?orderIncrease;
  num?incomeIncrease;


  DashboardResponse(
      this.statusCode,
      this.message,
      this.sales,
      this.uniqueOrders,
      this.totalOrder,
      this.totalIncome,
      this.orderIncrease,
      this.incomeIncrease);

  factory DashboardResponse.fromJson(Map<String,dynamic>json)=>
      _$DashboardResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$DashboardResponseToJson(this);
}
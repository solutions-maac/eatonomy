// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'ChefData.dart';

part 'ChefRresponse.g.dart';

@JsonSerializable()
class ChefRresponse{

  num? statusCode;
  String?message;
  List<ChefData>?chefAdmins;


  ChefRresponse(this.statusCode, this.message, this.chefAdmins);

  factory ChefRresponse.fromJson(Map<String,dynamic>json)=>
      _$ChefRresponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefRresponseToJson(this);
}
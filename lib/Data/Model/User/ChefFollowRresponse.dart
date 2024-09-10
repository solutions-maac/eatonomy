// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'ChefData.dart';

part 'ChefFollowRresponse.g.dart';

@JsonSerializable()
class ChefFollowRresponse{

  num? statusCode;
  String?message;
  List<ChefData>?follows;


  ChefFollowRresponse(this.statusCode, this.message, this.follows);

  factory ChefFollowRresponse.fromJson(Map<String,dynamic>json)=>
      _$ChefFollowRresponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefFollowRresponseToJson(this);
}
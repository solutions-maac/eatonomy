// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Chef.dart';

part 'ChefNearbyRresponse.g.dart';

@JsonSerializable()
class ChefNearbyRresponse{

  num? statusCode;
  String?message;
  List<Chef>?chefs;


  ChefNearbyRresponse(this.statusCode, this.message, this.chefs);

  factory ChefNearbyRresponse.fromJson(Map<String,dynamic>json)=>
      _$ChefNearbyRresponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefNearbyRresponseToJson(this);
}
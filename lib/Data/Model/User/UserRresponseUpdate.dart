// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'UserRresponseUpdate.g.dart';

@JsonSerializable()
class UserRresponseUpdate{

  bool? success;
  String?message;
  User?data;


  UserRresponseUpdate(this.success, this.message, this.data);

  factory UserRresponseUpdate.fromJson(Map<String,dynamic>json)=>
      _$UserRresponseUpdateFromJson(json);
  Map<String,dynamic>toJson()=>_$UserRresponseUpdateToJson(this);
}


// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import '../User/Chef.dart';
import 'DataBean.dart';
import 'ErrorModel.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse{


  bool? success;
  num? statusCode;
  Chef? chef;
  String? message;
  dynamic? error;
  String? token;
  String? name;
  String? email;
  String? mobileNumber;
  String? profilePicture;
  String? chefId;
  String? type;
  num? rating;


  LoginResponse(
      this.success,
      this.statusCode,
      this.chef,
      this.message,
      this.error,
      this.token,
      this.name,
      this.email,
      this.mobileNumber,
      this.profilePicture,
      this.chefId,
      this.type,
      this.rating);

  factory LoginResponse.fromJson(Map<String,dynamic>json)=>
      _$LoginResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$LoginResponseToJson(this);
}




// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'DataBean.dart';
import 'ErrorModel.dart';

part 'ForgetPasswordResponse.g.dart';

@JsonSerializable()
class ForgetPasswordResponse{


  bool? success;
  String? message;
  bool? data;
  String? error;
  ErrorModel? errors;


  ForgetPasswordResponse(this.success, this.message, this.data, this.error);

  factory ForgetPasswordResponse.fromJson(Map<String,dynamic>json)=>
      _$ForgetPasswordResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ForgetPasswordResponseToJson(this);
}




// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'DataBean.dart';
import 'ErrorModel.dart';

part 'OtpResponse.g.dart';

@JsonSerializable()
class OtpResponse{


  bool? success;
  num? status;
  num? statusCode;
  String? message;
  String? error;
  String? url;


  OtpResponse(this.success, this.status, this.statusCode, this.message,
      this.error, this.url);

  factory OtpResponse.fromJson(Map<String,dynamic>json)=>
      _$OtpResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$OtpResponseToJson(this);
}


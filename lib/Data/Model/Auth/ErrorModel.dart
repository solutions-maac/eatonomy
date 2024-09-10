// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

part 'ErrorModel.g.dart';

@JsonSerializable()
class ErrorModel{


  List<String>? mobile;
  List<String>? name;
  List<String>? email;
  List<String>? password;
  List<String>? password_confirmation;


  ErrorModel(this.mobile, this.name, this.email, this.password,
      this.password_confirmation);

  factory ErrorModel.fromJson(Map<String,dynamic>json)=>
      _$ErrorModelFromJson(json);
  Map<String,dynamic>toJson()=>_$ErrorModelToJson(this);
}
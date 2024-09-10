

// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';
import 'ErrorModel.dart';

part 'DataBean.g.dart';

@JsonSerializable()
class DataBean{


  User? user;
  User? user_profile;
  String? token;
  String? role;


  DataBean(this.user, this.user_profile, this.token, this.role);

  factory DataBean.fromJson(Map<String,dynamic>json)=>
      _$DataBeanFromJson(json);
  Map<String,dynamic>toJson()=>_$DataBeanToJson(this);
}


 class Data{
   User? user;
   User? user_profile;
   String? token;


   Data(this.user, this.user_profile,this.token);
}
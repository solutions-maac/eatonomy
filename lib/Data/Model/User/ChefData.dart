// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'Chef.dart';
import 'User.dart';

part 'ChefData.g.dart';

@JsonSerializable()
class ChefData{


  String?id;
  String?chefId;
  String?userId;
  String?status;
  Chef?chef;


  ChefData(this.id, this.chefId, this.userId, this.status, this.chef);

  factory ChefData.fromJson(Map<String,dynamic>json)=>
      _$ChefDataFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefDataToJson(this);
}
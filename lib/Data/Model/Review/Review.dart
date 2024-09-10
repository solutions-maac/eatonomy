// ignore_for_file: file_names
import 'package:eatonomy/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Location/LocationModel.dart';


part 'Review.g.dart';

@JsonSerializable()
class Review{

  String? id;
  String? chefId;
  String? orderId;
  String? createdAt;
  String? comment;
  String? updatedAt;
  String? text;
  User? userInfo;
  num? rating;
  num? count;


  Review(this.id, this.chefId, this.orderId, this.createdAt, this.comment,
      this.updatedAt, this.text, this.userInfo, this.rating, this.count);

  factory Review.fromJson(Map<String,dynamic>json)=>
      _$ReviewFromJson(json);
  Map<String,dynamic>toJson()=>_$ReviewToJson(this);
}
// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'Feed.dart';

part 'WishResponse.g.dart';

@JsonSerializable()
class WishResponse{

  String? message;
  num? statusCode;
  List<Feed>? follows;

  WishResponse(this.message, this.statusCode, this.follows);

  factory WishResponse.fromJson(Map<String,dynamic>json)=>
      _$WishResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$WishResponseToJson(this);
}
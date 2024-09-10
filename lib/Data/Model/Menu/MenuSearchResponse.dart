// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'Feed.dart';
import 'Menu.dart';

part 'MenuSearchResponse.g.dart';

@JsonSerializable()
class MenuSearchResponse{

  String? message;
  num? statusCode;
  List<Menu>? menus;

  MenuSearchResponse(this.message, this.statusCode, this.menus);

  factory MenuSearchResponse.fromJson(Map<String,dynamic>json)=>
      _$MenuSearchResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$MenuSearchResponseToJson(this);
}
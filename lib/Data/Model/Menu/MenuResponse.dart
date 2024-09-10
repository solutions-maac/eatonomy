// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'Feed.dart';

part 'MenuResponse.g.dart';

@JsonSerializable()
class MenuResponse{

  String? message;
  num? statusCode;
  List<Feed>? feeds;

  MenuResponse(this.message, this.statusCode, this.feeds);

  factory MenuResponse.fromJson(Map<String,dynamic>json)=>
      _$MenuResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$MenuResponseToJson(this);
}
// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'NotificationModel.dart';

part 'NotificationResponse.g.dart';

@JsonSerializable()
class NotificationResponse{



  String? message;
  num? totalPages;
  num? statusCode;
  num? status;
  num? totalElements;
  num? numberOfElements;
  num? currentPageNumber;
  bool? first;
  bool? last;
  List<NotificationModel>notifications;


  NotificationResponse(
      this.message,
      this.totalPages,
      this.statusCode,
      this.status,
      this.totalElements,
      this.numberOfElements,
      this.currentPageNumber,
      this.first,
      this.last,
      this.notifications);

  factory NotificationResponse.fromJson(Map<String,dynamic>json)=>
      _$NotificationResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$NotificationResponseToJson(this);
}
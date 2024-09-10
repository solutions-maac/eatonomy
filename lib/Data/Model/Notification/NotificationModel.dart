// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

part 'NotificationModel.g.dart';

@JsonSerializable()
class NotificationModel{



  String? id;
  String? userId;
  String? title;
  String? message;
  String? image;
  String? type;
  String? typeId;
  String? createdAt;
  String? status;





  NotificationModel(this.id, this.userId, this.title, this.message, this.image,
      this.type, this.typeId, this.createdAt, this.status);

  factory NotificationModel.fromJson(Map<String,dynamic>json)=>
      _$NotificationModelFromJson(json);
  Map<String,dynamic>toJson()=>_$NotificationModelToJson(this);
}
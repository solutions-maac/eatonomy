// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
import '../User/User.dart';
part 'Chat.g.dart';

@JsonSerializable()
class Chat{

  String? id;
  String? orderId;
  String? message;
  String? type;
  String? createdAt;
  User? sender;


  Chat(this.id, this.orderId, this.message, this.type, this.createdAt,
      this.sender);

  factory Chat.fromJson(Map<String,dynamic>json)=>
      _$ChatFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatToJson(this);
}
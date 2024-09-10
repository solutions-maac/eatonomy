// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import 'Chat.dart';


part 'ChatResponse.g.dart';

@JsonSerializable()
class ChatResponse{

  num? statusCode;
  String? message;
  List<Chat>?chats;


  ChatResponse(this.statusCode, this.message, this.chats);

  factory ChatResponse.fromJson(Map<String,dynamic>json)=>
      _$ChatResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChatResponseToJson(this);
}
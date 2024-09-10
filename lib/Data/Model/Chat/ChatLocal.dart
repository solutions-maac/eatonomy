

enum ChatType {
  Text,
  Image,
  YesAvailable,
  Selectyourtime,
  SelectLocation,
  MyConditions,
  Yourmenubills,
  Yourorderconfirmed,
  Yourorderdelivered
}

class ChatModel{
  bool? sender;
  String? text;
  String? date;
  String? profilepic;
  ChatType? type;

  ChatModel({this.sender,this.text,this.type,this.profilepic,this.date});

}
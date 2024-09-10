// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

part 'ChefUser.g.dart';

@JsonSerializable()
class ChefUser{

  String? id;
  String? verification_code;
  String? mobile;
  String? name;
  String? email;
  String? email_verified_at;
  String? two_factor_secret;
  String? google_id;
  String? facebook_id;
  String? note;
  num? status;
  num? notification_status;
  String? role;
  String? photo;
  String? profilePicture;
  String? signature;
  String? firstname;
  String? lastname;
  String? language;
  String? bio;
  String? social;
  String? created_at;


  ChefUser(
      this.id,
      this.verification_code,
      this.mobile,
      this.name,
      this.email,
      this.email_verified_at,
      this.two_factor_secret,
      this.google_id,
      this.facebook_id,
      this.note,
      this.status,
      this.notification_status,
      this.role,
      this.photo,
      this.profilePicture,
      this.signature,
      this.firstname,
      this.lastname,
      this.language,
      this.bio,
      this.social,
      this.created_at);

  factory ChefUser.fromJson(Map<String,dynamic>json)=>
      _$ChefUserFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefUserToJson(this);
}
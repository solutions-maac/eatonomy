// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User{

  @JsonKey(name: "id")
  String? id;
  String? verification_code;
  String? mobile;
  String? mobileNumber;
  String? name;
  String? profilePicture;
  String? email;
  String? address;
  String? city;
  String? zipCode;
  String? email_verified_at;
  String? two_factor_secret;
  String? google_id;
  String? facebook_id;
  String? note;
  num? status;
  num? rating;
  num? notification_status;
  String? role;
  String? photo;
  String? signature;
  String? firstname;
  String? lastname;
  String? language;
  String? bio;
  String? social;
  String? created_at;


  User(
      this.id,
      this.verification_code,
      this.mobile,
      this.mobileNumber,
      this.name,
      this.profilePicture,
      this.email,
      this.address,
      this.city,
      this.zipCode,
      this.email_verified_at,
      this.two_factor_secret,
      this.google_id,
      this.facebook_id,
      this.note,
      this.status,
      this.rating,
      this.notification_status,
      this.role,
      this.photo,
      this.signature,
      this.firstname,
      this.lastname,
      this.language,
      this.bio,
      this.social,
      this.created_at);

  factory User.fromJson(Map<String,dynamic>json)=>
      _$UserFromJson(json);
  Map<String,dynamic>toJson()=>_$UserToJson(this);
}
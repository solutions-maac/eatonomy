// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import '../Location/LocationModel.dart';
import 'ChefUser.dart';
import 'User.dart';

part 'Chef.g.dart';

@JsonSerializable()
class Chef{

  String? id;
  String? userId;
  String? mobileNumber;
  String? name;
  String? profilePicture;
  String? paymentInstruction;
  LocationModel? location;
  String? zipCode;
  String? city;
  String? address;
  String? email;
  String? banner;
  num? rating;
  num? experience;
  String? about;
  dynamic referralCode;
  ChefUser? user;
  bool?isFollowed;
  bool?isHotDeal;
  num?numberOfItem;


  Chef(
      this.id,
      this.userId,
      this.mobileNumber,
      this.name,
      this.profilePicture,
      this.paymentInstruction,
      this.location,
      this.zipCode,
      this.city,
      this.address,
      this.email,
      this.banner,
      this.rating,
      this.experience,
      this.about,
      this.referralCode,
      this.user,
      this.isFollowed,
      this.isHotDeal,
      this.numberOfItem);

  factory Chef.fromJson(Map<String,dynamic>json)=>
      _$ChefFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefToJson(this);
}
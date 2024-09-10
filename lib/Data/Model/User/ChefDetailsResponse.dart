// ignore_for_file: file_names

import 'package:eatonomy/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Menu/Menu.dart';
import '../Review/Review.dart';
import '../Review/StarReview.dart';
import 'Chef.dart';



part 'ChefDetailsResponse.g.dart';

@JsonSerializable()
class ChefDetailsResponse{

  String? message;
  num? statusCode;
  bool? isFollowed;
  Chef? chef;
  User? user;
  List<Menu>? menus;
  List<Review>? reviews;
  List<StarReview>? reviewStats;
  num? totalWeeklyOrder;
  num? totalPartyOrder;
  List<Review>? compliments;


  ChefDetailsResponse(
      this.message,
      this.statusCode,
      this.isFollowed,
      this.chef,
      this.user,
      this.menus,
      this.reviews,
      this.reviewStats,
      this.totalWeeklyOrder,
      this.totalPartyOrder,
      this.compliments);

  factory ChefDetailsResponse.fromJson(Map<String,dynamic>json)=>
      _$ChefDetailsResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ChefDetailsResponseToJson(this);
}
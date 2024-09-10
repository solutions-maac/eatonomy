// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../User/Chef.dart';
import 'Menu.dart';



part 'Feed.g.dart';

@JsonSerializable()
class Feed{

  String? id;
  String? chefId;
  String? userId;
  String? createdAt;
  String? type;
  String? description;
  String? typeId;
  num? price;
  bool? alreadyInWishList;
  bool? isActive;
  Menu?menu;
  List<String>? images;
  Chef? chef;


  Feed(
      this.id,
      this.chefId,
      this.userId,
      this.createdAt,
      this.type,
      this.description,
      this.typeId,
      this.price,
      this.alreadyInWishList,
      this.isActive,
      this.menu,
      this.images,
      this.chef);

  factory Feed.fromJson(Map<String,dynamic>json)=>
      _$FeedFromJson(json);
  Map<String,dynamic>toJson()=>_$FeedToJson(this);
}
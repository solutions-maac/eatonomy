// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import '../User/Chef.dart';



part 'Menu.g.dart';

@JsonSerializable()
class Menu{

  String? id;
  num? price;
  String? title;
  String? type;
  String? orderTakingInstruction;
  String? deliveryInstruction;
  String? chefId;
  String? deliveryDay;
  num? deliveryFrom;
  num? deliveryTo;
  num? discountedPrice;
  num? orderTakingBeforeDelivery;
  String? createdAt;
  String? cuisine;
  bool?isPickUpAvailable;
  bool?isHotDeal;
  bool?alreadyInWishList;
  bool?isDeliveryAvailable;
  List<String>? menus;
  List<String>? images;
  Chef? chef;


  Menu(
      this.id,
      this.price,
      this.title,
      this.type,
      this.orderTakingInstruction,
      this.deliveryInstruction,
      this.chefId,
      this.deliveryDay,
      this.deliveryFrom,
      this.deliveryTo,
      this.discountedPrice,
      this.orderTakingBeforeDelivery,
      this.createdAt,
      this.cuisine,
      this.isPickUpAvailable,
      this.isHotDeal,
      this.alreadyInWishList,
      this.isDeliveryAvailable,
      this.menus,
      this.images,
      this.chef);

  factory Menu.fromJson(Map<String,dynamic>json)=>
      _$MenuFromJson(json);
  Map<String,dynamic>toJson()=>_$MenuToJson(this);
}
import 'dart:io';


import 'package:eatonomy/Data/Model/Dashboard/DashboardResponse.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:logger/logger.dart';

import '../../Data/Model/Auth/ForgetPasswordResponse.dart';
import '../../Data/Model/Auth/LoginResponse.dart';
import '../../Data/Model/Auth/OtpResponse.dart';
import '../../Data/Model/Location/LocationModel.dart';
import '../../Data/Model/Menu/MenuResponse.dart';
import '../../Data/Model/Menu/MenuSearchResponse.dart';
import '../../Data/Model/Menu/WishResponse.dart';
import '../../Data/Model/User/ChefDetailsResponse.dart';
import '../../Data/Model/User/ChefFollowRresponse.dart';
import '../../Data/Model/User/ChefNearbyRresponse.dart';
import '../../Data/Model/User/ChefRresponse.dart';
import '../../Data/Model/User/UserRresponseUpdate.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Network/api_client.dart';

class ChefRepository{



  Future getCheck()async{
    getIt<ApiClient>().getData(uri: "target/last-sevenday-data");
    // apiClient.getData(uri: "target/last-sevenday-data",headers: {"xxx":"xxxx"});
  }



  Future<OtpResponse?> uploadImage(File? image)async{

    Map<String, String> data = {

    };
    final userRaw=await  getIt<ApiClient>().postMultipartData(uri: "file/v1", body: data,
        multipartBody:image==null?[]: [
          MultipartBody('image', image)
        ]
    );
    if(userRaw==null){
      return null;
    }else{
      return OtpResponse.fromJson(userRaw);
    }

  }

  Future<LoginResponse?> createChef({
    String? mobile,  String? email,String? name,String? address,
    String? paymentInstraction,LocationModel? locationdata,
    String? city,String? zipcode,String? bannerImage,String? profileImage,
    int? eperince,List<String>?couisine})async {

    Map<String, dynamic> location =  {
    "latitude": locationdata!.latitude,
    "longitude": locationdata.longitude
    };

    Map<String, dynamic> data = {
      "address": address!,
      "banner": bannerImage!,
      "city": city!,
      "email": email!,
      "location":location,
      "mobileNumber": mobile!,
      "name": name!,
      "paymentInstruction": paymentInstraction!,
      "profilePicture": profileImage!,
      "zipCode": zipcode!,
      "experience":eperince,
      "cuisines":couisine
    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "chef/v1/new-chef", body: data,);
    
    return LoginResponse.fromJson(userRaw);
  }




  Future<ChefRresponse> getShopList()async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "user/v1/get-my-shops");
    return ChefRresponse.fromJson(userRaw);
  }
  Future<ChefDetailsResponse> getChefDetails(String? id)async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "chef/v1/details?chefId="+id!);
    Logger().i(userRaw);
    return ChefDetailsResponse.fromJson(userRaw);
  }


  Future<ChefDetailsResponse> getUserDetails()async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "user/v1/details");
    Logger().i(userRaw);
    return ChefDetailsResponse.fromJson(userRaw);
  }


  Future<LoginResponse?> createMenu({
    String?chefId ,List<String>? images,bool? isDeliveryAvailable,
    bool? isPickUpAvailable,
    List<String>? menus,
    String? orderTakingInstruction,String? price,String? title,
    String? type,
    String? deliveryFrom,
    String? deliveryDay,
    String? deliveryTo,
    String? selectCuisine,
    bool? isHotDeal,
    String? discount,

  })async {


    Map<String, dynamic> data = {
      "chefId": chefId,
      "cuisine": selectCuisine!,
      "images": images,
      "isDeliveryAvailable": isDeliveryAvailable,
      "isPickUpAvailable": isPickUpAvailable,
      "deliveryDay": deliveryDay,
      "deliveryFrom": int.parse(deliveryFrom!),
      "deliveryTo": int.parse(deliveryTo!),
      "menus": menus,
      "orderTakingBeforeDelivery": int.parse(orderTakingInstruction!),
      "price": num.parse(price!),
      "title": title,
      "type": type,
      "isHotDeal": isHotDeal,
      "discountedPrice":discount==""?null: num.parse(discount!),

    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "chef/v1/add-menu", body: data,);

    return LoginResponse.fromJson(userRaw);
  }


  Future<MenuResponse> feedMenu(String limit,String page,List<String> url, LatLng? value)async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "feed/v1/search?"+"by=$url"+"&page=$page&limit=$limit",);
    Logger().e(userRaw);
    return MenuResponse.fromJson(userRaw);
  }

  Future<ChefNearbyRresponse> getChefs(String limit,String? page,double? radius,rating,List<String>cusin)async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "chef/v1/near-by?rating=${rating==0.0?"":rating}${cusin.isEmpty?"":"&cuisine=${cusin.isEmpty?"":cusin[0]}"}&radius=${radius==0.0?"":radius!.toInt()}&page=$page&limit=$limit");

    Logger().w(userRaw);
    return ChefNearbyRresponse.fromJson(userRaw);
  }

  Future<ChefNearbyRresponse> getnewChef(String limit, String page) async{
    final userRaw=await  getIt<ApiClient>().getData(uri: "chef/v1/recent?page=$page&limit=$limit");
    // Logger().e(userRaw);
    return ChefNearbyRresponse.fromJson(userRaw);
  }

  Future<MenuSearchResponse> searchMenu(String value) async{
    final userRaw=await  getIt<ApiClient>().getData(uri: "chef/v1/menu-search?key=$value");

    Logger().w(userRaw);
    return MenuSearchResponse.fromJson(userRaw);
  }

  Future<ChefNearbyRresponse> topChef()async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "chef/v1/top");
    return ChefNearbyRresponse.fromJson(userRaw);
  }

  Future<OtpResponse?> followChef(String id)async{

    Map<String, String> data = {
      "chefId": id
    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "chef-follow/v1", body: data,);
    return OtpResponse.fromJson(userRaw);
  }

  Future<OtpResponse?> deleteFollowChef(String id)async{

    Map<String, String> data = {
      "chefId": id
    };
    final userRaw=await  getIt<ApiClient>().deleteData(uri: "chef-follow/v1", body: data,);
    return OtpResponse.fromJson(userRaw);
  }

 Future<ChefFollowRresponse>  getFollowChefs(String limit,String? page,)async {
   final userRaw=await  getIt<ApiClient>().getData(uri: "chef-follow/v1?page=$page&limit=$limit");
   Logger().w(userRaw);
   return ChefFollowRresponse.fromJson(userRaw);
 }


  Future<LoginResponse?> addWishListMenu(String id)async{

    Map<String, String> data = {
      "menuId": id
    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "menu-follow/v1", body: data,);
    return LoginResponse.fromJson(userRaw);
  }
  Future<LoginResponse?> removeWishListMenu(String id)async{
    final userRaw=await  getIt<ApiClient>().deleteData(uri: "menu-follow/v1?menuId=$id",body: {});
    return LoginResponse.fromJson(userRaw);
  }

 Future<WishResponse> getWishList(String limit,String? page,)async {
   final userRaw=await  getIt<ApiClient>().getData(uri: "menu-follow/v1?page=$page&limit=$limit",);

   Logger().w(userRaw);
   return WishResponse.fromJson(userRaw);
 }


  Future<OtpResponse> updateChefAbout(String id, String about)async {
    Map<String, String> data = {
      "about": about,
      "chefId": id
    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "chef/v1/about",body: data);
    return OtpResponse.fromJson(userRaw);
  }

  Future<OtpResponse> updateChef({String? id,  String? name,
    String? address,  String? city,
    String? zipcode,  String? email,  String? mobile,  String? bannerImage,
    LocationModel? locationdata,  String? paymentInstraction,
    String? profileImage,  String? about})async {


    Map<String, dynamic> location =   locationdata!=null? {
      "latitude": locationdata.latitude,
      "longitude": locationdata.longitude
    }: {
    "latitude": 0,
    "longitude": 0
    };

    Map<String, dynamic> data = {
      "address": address!,
      "banner": bannerImage!,
      "city": city!,
      "email": email!,
      "chefId": id,
      "location":location,
      "mobileNumber": mobile!,
      "name": name!,
      "paymentInstruction": paymentInstraction!,
      "profilePicture": profileImage!,
      "zipCode": zipcode!,
      "about":about!
    };

    final userRaw=await  getIt<ApiClient>().putData(uri: "chef/v1/edit-chef", body: data,);

    return OtpResponse.fromJson(userRaw);
  }




  Future<LoginResponse?> updateMenu({
    String?menuId ,List<String>? images,bool? isDeliveryAvailable,
    bool? isPickUpAvailable,
    List<String>? menus,
    String? orderTakingInstruction,String? price,
    String? title,String? type,
    required String deliveryFrom,
    required String deliveryDay,
    required String deliveryTo,
    String? selectCuisine,
    bool? isHotDeal,
    String? discount,
  })async {


    Map<String, dynamic> data = {
      "menuId": menuId!,
      "images": images,
      "cuisine": selectCuisine!,
      "isDeliveryAvailable": isDeliveryAvailable,
      "isPickUpAvailable": isPickUpAvailable,
      "deliveryDay": deliveryDay,
      "deliveryFrom": int.parse(deliveryFrom),
      "deliveryTo": int.parse(deliveryTo),
      "menus": menus,
      "orderTakingBeforeDelivery": int.parse(orderTakingInstruction!),
      "price": double.parse(price!),
      "title": title,
      "type": type,
      "isHotDeal": isHotDeal,
      "discountedPrice":discount==null?null: double.parse(discount),
    };

    final userRaw=await  getIt<ApiClient>().putData(uri: "chef/v1/edit-menu", body: data,);

    return LoginResponse.fromJson(userRaw);
  }

 Future<DashboardResponse> getChefOrderPerformance(bool? type) async{
   final userRaw=await  getIt<ApiClient>().getData(uri: "dashboard/v1/revenue?isMonthly=$type",);

   Logger().w(userRaw);
   return DashboardResponse.fromJson(userRaw);
 }





}
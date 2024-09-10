import 'dart:io';



import 'package:eatonomy/Data/Model/Chat/ChatResponse.dart';
import 'package:logger/logger.dart';

import '../../Data/Model/Auth/OtpResponse.dart';
import '../../Data/Model/Home/Slider/SliderResponse.dart';
import '../../Data/Model/Order/OrderDetailsResponse.dart';
import '../../Data/Model/Order/OrderMenuResponse.dart';
import '../../Data/Model/Order/OrderResponse.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Network/api_client.dart';

class OrderRepository{




 Future getCheck()async{
    getIt<ApiClient>().getData(uri: "target/last-sevenday-data");
    // apiClient.getData(uri: "target/last-sevenday-data",headers: {"xxx":"xxxx"});
  }

  Future<SliderResponse> getSlider() async{
    final userRaw=await getIt<ApiClient>().getData(uri: "slide");

    return SliderResponse.fromJson(userRaw);
  }

 Future<OrderDetailsResponse>  createOrder(
     {String? address, deliveryoption, id, int? qty,  String? fromTime,toTime}) async{

   Map<String, dynamic> data = {
     "deliveryAddress": address!,
     "deliveryOption": deliveryoption,
     "fromTime": fromTime,
     "toTime": toTime,
     "menuId": id,
     "quantity": qty
   };

   final userRaw=await getIt<ApiClient>().postData(uri: "order/v1/new",body: data);

   return OrderDetailsResponse.fromJson(userRaw);
  }


 Future<OrderResponse>  orderHistory(String limit, String page, String? status,bool? isChef)  async{
   final userRaw=
       isChef!?
       await getIt<ApiClient>().getData(uri: "order/v1/chef/my-orders?status=$status&page=$page&limit=$limit")
       :
      await getIt<ApiClient>().getData(uri: "order/v1/user/my-orders?status=$status&page=$page&limit=$limit");

   Logger().w(userRaw);
   return OrderResponse.fromJson(userRaw);
 }

 Future<OrderMenuResponse> orderMenuHistory()  async{
   final userRaw=await getIt<ApiClient>().getData(uri: "order/v1/chef/upcoming-menu-wise-stat");

   Logger().w(userRaw);
   return OrderMenuResponse.fromJson(userRaw);
 }
 Future<OrderResponse> orderMenuFullHistory(String? menuId)  async{
   final userRaw=await getIt<ApiClient>().getData(uri: "order/v1/chef/upcoming-by-menu?menuId=$menuId");

   Logger().w(userRaw);
   return OrderResponse.fromJson(userRaw);
 }




 Future<OrderDetailsResponse>   orderDetails(String? ordrId)   async{
   final userRaw=await getIt<ApiClient>().getData(uri: "order/v1/details?orderId=$ordrId");

   Logger().w(userRaw);
   return OrderDetailsResponse.fromJson(userRaw);
 }

 Future<OtpResponse?> oderAccepted(String? ordrId,double?deliveryCharge) async{

   Map<String, dynamic> data = deliveryCharge==null?
   {
     "orderId": ordrId
   }
       :
   {
     "deliveryCharge":deliveryCharge,
     "orderId": ordrId
   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/accepted-by-chef",body:data );

   return OtpResponse.fromJson(userRaw);
  }

 Future<OtpResponse?> oderpaymenrResquest(String? ordrId,String? orderPaymentNote,String? paymentImage) async{
   Map<String, dynamic> data = {
     "image": paymentImage,
     "message": orderPaymentNote,
     "orderId": ordrId
   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/payment-request-by-customer",body:data );

   return OtpResponse.fromJson(userRaw);
 }

 Future<OtpResponse?>  sendSuport(String? ordrId, String type,String text, String image)  async{
   Map<String, dynamic> data = {
     "image": image,
     "note": text,
     "orderId": ordrId,
     "type":type
   };
   final userRaw=await getIt<ApiClient>().postData(uri: "support/v1",body:data );

   return OtpResponse.fromJson(userRaw);
 }


 Future<OtpResponse?> oderPaymentAccepted(String? ordrId) async{
   Map<String, dynamic> data = {

   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/payment-confirm-by-chef?orderId=$ordrId",body:data );

   return OtpResponse.fromJson(userRaw);
 }
 Future<OtpResponse?> oderReadyFor(String? ordrId) async{
   Map<String, dynamic> data = {

   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/ready-for-pick-up?orderId=$ordrId",body:data );

   return OtpResponse.fromJson(userRaw);
 }

 Future<OtpResponse?> oderComplete(String? ordrId) async{
   Map<String, dynamic> data = {

   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/completed?orderId=$ordrId",body:data );

   return OtpResponse.fromJson(userRaw);
 }



 Future<OtpResponse?> uploadImage(File? image)async{

   Map<String, String> data = {

   };
   final userRaw=await  getIt<ApiClient>().postMultipartData(uri: "file/v1", body: data,
       multipartBody:image==null?[]: [
         MultipartBody('image', image)
       ]
   );
   return OtpResponse.fromJson(userRaw);
 }


 Future<OtpResponse?> submitReview(
        {
          String? ordrId,
          commenet,
          int? rarting1,
          int? rarting2,
          int? rarting3,
          int? rarting4
        }
      ) async{
   Map<String, dynamic> data = {
     "comment": commenet,
     "orderId": ordrId,
     "rating": [
       {
         "rating": rarting1,
         "text": "Please rate their service?"
       },
       {
         "rating": rarting2,
         "text": "Please rate their food hygiene."
       },
       {
         "rating": rarting3,
         "text": "Please rate their service intensity."
       },
       {
         "rating": rarting4,
         "text": "Please rate their timeliness."
       },
     ]

   };
   final userRaw=await getIt<ApiClient>().postData(uri: "order/v1/review",body:data );

   return OtpResponse.fromJson(userRaw);
 }


 Future<OtpResponse?> chefSubmitReview(String? ordrId,commenet,int rarting) async{
   Map<String, dynamic> data = {
     "comment": commenet,
     "orderId": ordrId,
     "rating": rarting
   };
   final userRaw=await getIt<ApiClient>().postData(uri: "order/v1/review-by-chef",body:data );

   return OtpResponse.fromJson(userRaw);
 }




 Future<OtpResponse?> oderCancel(String? ordrId) async{
   Map<String, dynamic> data = {

   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/cancel?orderId=$ordrId",body:data );

   return OtpResponse.fromJson(userRaw);
 }
 Future<OtpResponse?> rejectOrder(String? ordrId,rejectType) async{
   Map<String, dynamic> data = {

   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/reject?orderId=$ordrId&note=$rejectType",body:data );

   return OtpResponse.fromJson(userRaw);
 }
 Future<OtpResponse?> oderAcceptedbyCustome(String? ordrId)  async{
   Map<String, dynamic> data = {

   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/delivery-confirm-by-customer?orderId=$ordrId",body:data );

   return OtpResponse.fromJson(userRaw);
 }


 Future<OtpResponse?> chnageTime(String orderId, String from, String to) async{
   Map<String, dynamic> data = {
     "fromTime": from,
     "orderId": orderId,
     "toTime": to
   };
   final userRaw=await getIt<ApiClient>().putData(uri: "order/v1/change-time",body:data );

   return OtpResponse.fromJson(userRaw);
 }
 Future<ChatResponse?> orderChatHistory(String? ordrId) async{
   final userRaw=await getIt<ApiClient>().getData(uri: "chat/v1?orderId=$ordrId", );

   Logger().w(userRaw);
   return ChatResponse.fromJson(userRaw);
 }

 Future<OtpResponse?> orderChatSend({String? orderId, String? message, String? type}) async{
   Map<String, dynamic> data = {
     "message": message!,
     "orderId": orderId!,
     "type": type!
   };
   final userRaw=await getIt<ApiClient>().postData(uri: "chat/v1",body:data );

   return OtpResponse.fromJson(userRaw);
 }


















}
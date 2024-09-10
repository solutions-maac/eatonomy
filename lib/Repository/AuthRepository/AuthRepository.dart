import 'dart:io';


import 'package:logger/logger.dart';

import '../../Data/Model/Auth/ForgetPasswordResponse.dart';
import '../../Data/Model/Auth/LoginResponse.dart';
import '../../Data/Model/Auth/OtpResponse.dart';
import '../../Data/Model/User/ChefRresponse.dart';
import '../../Data/Model/User/UserRresponseUpdate.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Network/api_client.dart';

class AuthRepository{



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
    return OtpResponse.fromJson(userRaw);
  }

  Future<LoginResponse?> SignUp({
    String? mobile,  String? email,
    String? otp,String? name,String? iamge,String? address,
    String? city,String? zipcode,String? image})async {

    Map<String, String> data = {
      "address": address!,
      "city": city!,
      "email": email!,
      "mobileNumber": mobile!,
      "name": name!,
      "profilePicture": image!,
      "otp": otp!,
      "zipCode": zipcode!
    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "user/v1/registration", body: data,);

    return LoginResponse.fromJson(userRaw);
  }

  Future<LoginResponse?> signinFun(String email, String otp,bool? isChef) async{
    Map<String, dynamic> data = {
      "email": email,
      "isChef": isChef,
      "otp": otp
    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "user/v1/login", body: data);

    return LoginResponse.fromJson(userRaw);
  }

  Future<ForgetPasswordResponse> resetPassword(String email) async{
    Map<String, String> data = {
      'email': email,
    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "auth/forgot-password", body: data);

    return ForgetPasswordResponse.fromJson(userRaw);
  }





  Future<ForgetPasswordResponse>  passwordChange(String old, String newP, String confrim) async{
    Map<String, String> data = {
      'password': newP,
      'password_confirmation': confrim,
      'old_password': old,
    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "auth/change-password", body: data);

    return ForgetPasswordResponse.fromJson(userRaw);
  }

  Future<OtpResponse>  otpGet(String email) async{
    Map<String, String> data = {
      "recipient":  email,
    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "otp/v1/send", body: data);

    return OtpResponse.fromJson(userRaw);
  }

  Future<OtpResponse>  checkUserExist(String email, phone) async{
    Map<String, String> data = {
      "email": email,
      "mobileNumber": phone
    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "user/v1/check-existing-user", body: data);

    return OtpResponse.fromJson(userRaw);
  }

  Future<ChefRresponse> getShopList()async {
    final userRaw=await  getIt<ApiClient>().getData(uri: "user/v1/get-my-shops");
    Logger().w(userRaw);
    return ChefRresponse.fromJson(userRaw);
  }

  Future<LoginResponse> switchToShop(String? id) async{
    final userRaw=await  getIt<ApiClient>().postData(uri: "user/v1/switch-to-shop/"+id!,body: []);
    return LoginResponse.fromJson(userRaw);
  }


  Future<OtpResponse>  registerNotification({String? deviceId,deviceType,model,pushToken}) async{
    Map<String, String> data = {
      "deviceId": deviceId!,
      "deviceType": deviceType!,
      "model": model!,
      "pushToken": pushToken!
    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "notification/register/v1", body: data);

    return OtpResponse.fromJson(userRaw);
  }


  Future<LoginResponse>  switchToUser({String? deviceId,deviceType,model,pushToken}) async{
    Map<String, String> data = {

    };
    final userRaw=await  getIt<ApiClient>().postData(uri: "user/v1/switch-to-user", body: data);

    return LoginResponse.fromJson(userRaw);
  }

  Future<LoginResponse?> updateUser({String? iamge, String? mobile, String? email,  String? image, String? name,
    String? address, String? city, String? zipcode})async {
    Map<String, String> data = {
      "address": address!,
      "city": city!,
      "email": email!,
      "mobileNumber": mobile!,
      "name": name!,
      "profilePicture": image!,
      "zipCode": zipcode!
    };
    final userRaw=await  getIt<ApiClient>().putData(uri: "user/v1/edit", body: data);

    return LoginResponse.fromJson(userRaw);
  }


  Future<LoginResponse>  deleteAccount() async{
    Map<String, String> data = {

    };
    final userRaw=await  getIt<ApiClient>().deleteData(uri: "user/v1",);

    return LoginResponse.fromJson(userRaw);
  }





}
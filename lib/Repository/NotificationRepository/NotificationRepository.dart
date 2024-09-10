import 'dart:io';


import 'package:logger/logger.dart';

import '../../Data/Model/Auth/OtpResponse.dart';
import '../../Data/Model/Notification/NotificationResponse.dart';
import '../../Dependenci Injection/injection.dart';
import '../../Network/api_client.dart';

class NotificationRepository{


  Future<NotificationResponse> getNotification(int limit,page)async{
    final userRaw=await getIt<ApiClient>().getData(uri: "notification/v1?page="+page.toString()+"&limit="+limit.toString());
    // apiClient.getData(uri: "target/last-sevenday-data",headers: {"xxx":"xxxx"});


    Logger().w(userRaw);
    return NotificationResponse.fromJson(userRaw);
  }

  Future<OtpResponse?> OtpGet( String email)async {

    Map<String, String> data = {
      'recipient': email,
    };

    final userRaw=await  getIt<ApiClient>().postData(uri: "otp/v1/send", body: data);
    
    return OtpResponse.fromJson(userRaw);
  }

  Future<OtpResponse?> readNotification(String? id) async{
    Map<String, String> data = {

    };
    final userRaw=await  getIt<ApiClient>().putData(uri: "notification/v1/read/$id", body: data);
    Logger().w(userRaw);
    return OtpResponse.fromJson(userRaw);
  }

}
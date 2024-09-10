import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Data/Model/Notification/NotificationModel.dart';
import '../../Repository/NotificationRepository/NotificationRepository.dart';
import '../../Repository/SliderRepository/slider_repository.dart';

class NotificationController extends GetxController implements GetxService{
  final NotificationRepository? notificationRepository;

  NotificationController({ this.notificationRepository});
  
  ///=========Notificatiuon with pagination========///////
  final circle = false.obs;
  
  List<NotificationModel> list = [];
  ScrollController controller = ScrollController();
  int listLength = 10;
  int page = 0;
  final notificationPagingCirculer=false.obs;



  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        listLength++;
        page++;
        getNotificationPagingData(page: page.toString());
        update();
      }
    });
  }
  getNotification({String? idx, String? pagex}) async{
    circle.value=true;
    list.clear();
    page=0;
    addItems();
    await notificationRepository?.getNotification(
      20,
      pagex??'0',
    ).then((value){
      circle.value=false;
      // categoryCourseResponse.value=value;
      for(var i=0;i<value.notifications.length;i++){
        list.add(value.notifications[i]);
      }
      // Logger().w(list.length);
    });
  }
  getNotificationPagingData({String? page}) async{
    notificationPagingCirculer.value=true;
    await notificationRepository!.getNotification(
      20,
      page??'1',
    ).then((value){
      for(var i=0;i<value.notifications.length;i++){
        list.add(value.notifications[i]);
      }
      update();
      notificationPagingCirculer.value=false;
    });

  }

  void readNotification(String? id) async{
    await notificationRepository!.readNotification(id).then((value){

    update();
    });
  }
  
  
  
  
  
  

  // Rx<LocationModel?>  location=Rx<LocationModel?>(null);
  // increment() {
  //   currentIndex.value++;
  //   print("object");
  //
  //   sliderRepository!.getCheck();
  // }
}
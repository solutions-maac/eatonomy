import 'dart:async';

import 'package:eatonomy/Config/text_style.dart';
import 'package:eatonomy/Constants/Colors/app_colors.dart';
import 'package:eatonomy/Constants/Strings/app_strings.dart';
import 'package:eatonomy/GetX%20Controller/Home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../GetX Controller/Notification/NotificationController.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../../Widgets/Loading/loading_widget.dart';
import 'Component/notification_card.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getNotification();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notifications',),
      ),
      body: Container(
        color: Colors.white,
        height: 1.0.sh,
        width: 1.0.sw,
        child: GetBuilder<HomeController>(
          assignId: true,
          builder: (homeCntroller) {
            return GetBuilder<NotificationController>(
              assignId: true,
              builder: (controller) {
                return Obx(() {
                  return
                    homeCntroller.token.value==""?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You Are Not Registered",style: boldText(16,color: textColor),),
                            SizedBox(height: 8,),
                            InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, LOGIN_PAGE_INTRO);
                                },
                                child: Text("Please Signup",style: boldText(16,color: kPrimaryColor),)),

                          ],
                        )
                        :
                  controller.circle.value ? LoadingWidget() :
                  controller.list.isEmpty ? EmptyWidget(title: "You Have No Notifications",) :
                  ListView.builder(
                      controller: controller.controller,
                      itemCount: controller.list.length +
                          (controller.notificationPagingCirculer.value ? 1 : 0),
                      itemBuilder: (contex, index) {
                        if (index < controller.list.length) {
                          return InkWell(
                            onTap: (){
                              controller.list[index].status="READ";
                              controller.readNotification(controller.list[index].id);
                              controller.update();
                            },
                            child: NotificationCard(
                              title: controller.list[index].title,
                              message: controller.list[index].message,
                              image: controller.list[index].image,
                              createdAt: controller.list[index].createdAt,
                              status: controller.list[index].status,
                            ),
                          );
                        } else {
                          Timer(const Duration(milliseconds: 30), () {
                            controller.controller
                                .jumpTo(controller.controller.position
                                .maxScrollExtent);
                          });
                          return const Center(
                            child: CircularProgressIndicator(),);
                        }
                      }
                  );
                });
              },
            );
          },
        ),
      ),
    );
  }
}
// NotificationCard(),
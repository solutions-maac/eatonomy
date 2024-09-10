import 'package:easy_localization/easy_localization.dart';
import 'package:eatonomy/Presentation/Widgets/Loading/loading_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Config/text_style.dart';
import '../Constants/Colors/app_colors.dart';
import '../Dependenci Injection/injection.dart';
import '../GetX Controller/Home/HomeController.dart';
import '../Getx Injection/getx_dependenci_injection.dart';
import '../Repository/AuthRepository/AuthRepository.dart';
import 'Pages/Chef/BecomeChef/chef_profile_page.dart';
import 'Pages/Chef/chef_page.dart';
import 'Pages/Home/home_page.dart';
import 'Pages/More/more_page.dart';
import 'Pages/Notification/notification_page.dart';
import 'Pages/Order/chef_order_history.dart';
import 'Pages/Order/order_history.dart';
import 'Widgets/Button/custom_button.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().requestPermission(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            body: Container(
              height: 1.0.sh,
              width: 1.0.sw,
              child:controller.shopswitchChircule.value ?Center(child: LoadingWidget(),): SizedBox.expand(
                  child:
                  controller.selectedIndex.value==0? HomePage()
                      :controller.selectedIndex.value==1?
                  Get.find<HomeController>().chefId.value == "" ? OrderHistoryPage()
                      :ChefOrderHistoryPage():

                  controller.selectedIndex.value==2?
                  controller.chefId.value!=""?
                  ChefProfilePage(id:controller.chefId.value ,localUser: false,isButton: false,)
                      :
                  ChefPage()
                      :controller.selectedIndex.value==3?
                  NotificationPage()
                      :MorePage()
              ),
            ),
            bottomNavigationBar:controller.shopswitchChircule.value?null: SizedBox(
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                // unselectedLabelStyle: TextStyle(fontSize: 12.sp),
                // selectedLabelStyle: TextStyle(fontSize: 14.sp),
                onTap: controller.onItemTapped,
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: kPrimaryColorx,
                unselectedItemColor:  Color(0xFFA0C3B4),
                unselectedLabelStyle: TextStyle(color: Color(0xFFA0C3B4)),
                selectedLabelStyle: TextStyle(color: kPrimaryColorx),
                type: BottomNavigationBarType.fixed,
                items:
                [
                  controller.chefId.value!=""?
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        "assets/icons/graph.svg",
                        color: kPrimaryColorx,
                      ),
                      icon: Container(
                        child: SvgPicture.asset(
                          "assets/icons/graph.svg",
                          color: Color(0xFFA0C3B4),
                        ),
                      ),
                      label: "Dashboard"):
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        "assets/icons/Home.svg",
                        color: kPrimaryColorx,
                      ),
                      icon: Container(
                        child: SvgPicture.asset(
                          "assets/icons/Home.svg",
                          color: Color(0xFFA0C3B4),
                        ),
                      ),
                      label: "Home"),
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        "assets/icons/Paper.svg",
                        color: kPrimaryColorx,
                      ),
                      icon: Container(

                        child: SvgPicture.asset(
                          "assets/icons/Paper.svg",
                          color: Color(0xFFA0C3B4),
                        ),
                      ),
                      label: tr("Order")),
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        "assets/icons/Profile.svg",
                        color: kPrimaryColorx,
                      ),
                      icon: Container(

                        child: SvgPicture.asset(
                          "assets/icons/Profile.svg",
                          color: Color(0xFFA0C3B4),
                        ),
                      ),
                      label: tr(controller.chefId.value!=""?"Profile":"Chef")),
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        "assets/icons/Notification.svg",
                        color: kPrimaryColorx,
                      ),
                      icon: Container(

                        child: SvgPicture.asset(
                          "assets/icons/Notification.svg",
                          color: Color(0xFFA0C3B4),
                        ),
                      ),
                      label: tr("Notification")),
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        "assets/icons/grid.svg",
                        color: kPrimaryColorx,
                      ),
                      icon: Container(

                        child: SvgPicture.asset(
                          "assets/icons/grid.svg",
                          color: Color(0xFFA0C3B4),
                        ),
                      ),
                      label: tr("More")),


                ],
              ),
            ),
          );
        });
      },
    );
  }
}




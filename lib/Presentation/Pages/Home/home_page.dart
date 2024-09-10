import 'dart:async';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import '../../../Bloc/Slider/slider_cubit.dart';
import '../../../Config/text_style.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Dependenci Injection/injection.dart';
import '../../../GetX Controller/Home/HomeController.dart';
import '../../../GetX Controller/Menu/MenuController.dart';
import '../../../Network/api_client.dart';
import '../../../service/location_service.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/EmptyCard/empty_widget.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/cart_icon_widget.dart';
import 'Component/header_user_name_msg.dart';
import 'Component/home_header_user_profile.dart';
import 'Component/home_page_slider.dart';
import 'Component/menu_card.dart';
import 'Component/new_chef_card.dart';
import 'chef_dashboard_page.dart';
import 'chef_home_profile_page.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  List<String> filter=[ "Popular",
    "Nearby",
    "Following",
    "Trending",
    "Recent",
  ];


  @override
  void initState() {
    // TODO: implement initState
    getIt<LocationService>().getLocation();
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().onInit());
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().getShopList());
    Future.delayed(Duration.zero,()=>  Get.find<MenuControllerx>().getnewChef(true));
    Future.delayed(Duration.zero,()=>  Get.find<MenuControllerx>().getFeedMenu(Get.find<MenuControllerx>().homeFilterSelect, true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>().chefId.value==""?
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().onInit()):null;
    return Scaffold(
      backgroundColor: Color(0xFFF9FCFF),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF9FCFF),
        title: userProfileImage(),
        actions: [
          Get.find<HomeController>().chefId.value==""?
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, SEARCH_PAGE);
            },
            child: Container(
              height: 40,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(right: 16, left: 16, bottom: 12, top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFF2F3F5), width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                "assets/icons/search.svg", height: 16,
              ),
            ),
          ):SizedBox(),
        ],
      ),
      body: GetBuilder<MenuControllerx>(
        assignId: true,
        builder: (controller) {
          return GetBuilder<HomeController>(
            assignId: true,
            builder: (homeController) {
              return Obx(() {
                return
                  homeController.shopswitchChircule.value? LoadingWidget():
                  homeController.chefId.value!=""?
                  // ChefHomeProfilePage(id:homeController.chefId.value ,localUser: false,)
                  ChefDashboardPage(id:homeController.chefId.value ,localUser: false,)
                      :
                  Container(
                    color: BackgroundColorx,
                    height: 1.0.sh,
                    width: 1.0.sw,
                    child: RefreshIndicator(
                        onRefresh: () => refreshList(context),
                        child: CustomScrollView(
                          controller: controller.controller,
                          slivers: [
                            // SliverToBoxAdapter(
                            //     child: Container(
                            //       decoration: ShapeDecoration(
                            //         shape: RoundedRectangleBorder(
                            //           side: BorderSide(
                            //             width: 0.50,
                            //             color: Color(0xFFECE8E8),
                            //           ),
                            //         ),
                            //       ),
                            //     )
                            // ),
                            homeController.token.value==""||homeController.shopList.value==null||homeController.shopList.value!.chefAdmins==null|| homeController.shopList.value!.chefAdmins!.isNotEmpty?
                            homeController.token.value==""?
                            SliverToBoxAdapter(
                              child: Container(
                                  height: 158,
                                  // color: Colors.redAccent,
                                  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 0),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 130,
                                        width: 1.0.sw,
                                        decoration:BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft, end: Alignment.centerRight,
                                              colors:[Color(0xff00934c), Color(0xfffcb116)], )),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 24,),
                                                  Text(
                                                      "You can create chef account",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white
                                                      )
                                                  ),
                                                  SizedBox(height: 8,),
                                                  InkWell(
                                                    onTap: (){

                                                      Navigator.pushNamed(context, LOGIN_PAGE_INTRO);

                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 86,
                                                      padding: EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          color: Color(0xFFFCB116),
                                                          borderRadius: BorderRadius.circular(40)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                              homeController.token.value==""?"Signup Free": "Create",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500,
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],

                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 0),
                                              child: Image.asset(
                                                  "assets/images/chef.png",
                                                  width: 0.4.sw,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                            ):

                            SliverToBoxAdapter():
                            SliverToBoxAdapter(
                              child: Container(
                                  height: 158,///144
                                  // color: Colors.redAccent,
                                  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 0),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 130,///120
                                        width: 1.0.sw,
                                        decoration:BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft, end: Alignment.centerRight,
                                              colors:[Color(0xff00934c), Color(0xfffcb116)], )),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 24,),
                                                  Text(
                                                      "You can create chef account",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white
                                                      )
                                                  ),
                                                  SizedBox(height: 8,),
                                                  InkWell(
                                                    onTap: (){
                                                      if(homeController.token.value==""){
                                                        Navigator.pushNamed(context, LOGIN_PAGE_INTRO);
                                                      }else{
                                                        Navigator.pushNamed(context, BEACOME_SHEF_SLIDER_PAGE);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 86,
                                                      padding: EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          color: Color(0xFFFCB116),
                                                          borderRadius: BorderRadius.circular(40)
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.add),
                                                          SizedBox(width: 2,),
                                                          Text(
                                                              "Create",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500,
                                                              )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],

                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 0),
                                              child: Image.asset(
                                                  "assets/images/chef.png",
                                                  width: 0.4.sw,
                                                  height: 290///290
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                            ),

                            controller.chefList.isEmpty?SliverToBoxAdapter(): SliverToBoxAdapter(child: SizedBox(height: 24,)),
                            SliverToBoxAdapter(
                                child: controller.recentCgefcirculer.value ?
                                LoadingWidget() :
                                controller.chefList.isEmpty
                                    ? SizedBox()
                                    :
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'New Chef',
                                        style: TextStyle(
                                          color: Color(0xFF02190E),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      SizedBox(
                                        height: 145,
                                        child:
                                        ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            controller: controller.chefController,
                                            itemCount: controller.chefList
                                                .length +
                                                (controller.chefPagingCirculer
                                                    .value ? 1 : 0),
                                            itemBuilder: (contex, index) {
                                              if (index < controller.chefList
                                                  .length) {
                                                return NewChefCard(
                                                  token: homeController.token.value,
                                                  rating: controller
                                                      .chefList[index].rating.toString(),
                                                  index: index,
                                                  isFloow: controller
                                                      .chefList[index]
                                                      .isFollowed!=null?controller
                                                      .chefList[index]
                                                      .isFollowed!:false,
                                                  name: controller
                                                      .chefList[index].name,
                                                  image: controller
                                                      .chefList[index]
                                                      .profilePicture,
                                                  id: controller
                                                      .chefList[index].id,
                                                  address: controller
                                                      .chefList[index]
                                                      .address,
                                                );
                                              } else {
                                                Timer(const Duration(
                                                    milliseconds: 30), () {
                                                  controller.chefController
                                                      .jumpTo(controller
                                                      .chefController.position
                                                      .maxScrollExtent);
                                                });
                                                return const Center(
                                                  child: CircularProgressIndicator(),);
                                              }
                                            }
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),

                            SliverToBoxAdapter(child: SizedBox(height: 24,)),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text(
                                  'Menu List',
                                  style: TextStyle(
                                    color: Color(0xFF02190E),
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),),

                            SliverToBoxAdapter(
                                child: Container(
                                  width: 1.0.sw,
                                  height: 70,
                                  margin: EdgeInsets.only(top: 0),
                                  // color: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child:Center(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: filter.length,
                                        itemBuilder: (context,index){
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if(!controller.homeFilterSelect.contains(filter[index])){
                                                    controller.homeFilterSelect.add(filter[index]);
                                                    controller.update();
                                                  }else{
                                                    controller.homeFilterSelect.remove(filter[index]);
                                                    controller.update();
                                                  }

                                                  Get.find<MenuControllerx>().getFeedMenu(controller.homeFilterSelect, false);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(bottom: 0, right: 8),
                                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                                  decoration: ShapeDecoration(
                                                    color: controller.homeFilterSelect.contains(filter[index])
                                                        ? Color(0xFFD4ECE4)
                                                        : Color(0xFFFFFFFF),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(40),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color: Color(0x26A4B6AD),
                                                        blurRadius: 30,
                                                        offset: Offset(0, 8),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset("assets/icons/${filter[index].toLowerCase()}.svg"),
                                                      SizedBox(width: 6,),
                                                      Text(
                                                        filter[index],
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color(0xFF00934C),
                                                          fontSize: 12,
                                                          fontFamily: 'Sora',
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                child:controller.homeFilterSelect.contains(filter[index])?
                                                InkWell(
                                                  onTap:(){
                                                    controller.homeFilterSelect.removeWhere((element) => element==filter[index]);
                                                    controller.update();
                                                    Get.find<MenuControllerx>().getFeedMenu(controller.homeFilterSelect, false);
                                                  },
                                                  child: Container(
                                                    height: 16,
                                                    width: 16,
                                                    decoration: BoxDecoration(
                                                        color: Color(0XFFE43F3F),
                                                        borderRadius: BorderRadius.circular(100)
                                                    ),
                                                    child: Icon(Icons.close,color: Colors.white,size: 12,),
                                                  ),
                                                ):SizedBox(),
                                                right: 10,
                                                top: 10,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                )
                            ),
                            SliverToBoxAdapter(
                                child: controller.circle.value
                                    ? LoadingWidget()
                                    :
                                controller.list!=null&&controller.list!.isEmpty&&!controller.circle.value ? Container(
                                  padding: EdgeInsets.all(55),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/empty.png"),
                                      SizedBox(height: 11,),
                                      Text(
                                        'Currently, there are no cooks available in your region.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF8D8D8D),
                                          fontSize: 12,
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 24,),
                                      // CustomButton(
                                      //   height: 40,
                                      //   color: kPrimaryColorx,
                                      //   title: "Create Chef Account",
                                      //   orderRadius: 30,
                                      //   textColor: Colors.white,
                                      //   textSize: 12,
                                      //   onTap: (){
                                      //     if(homeController.token.value==""){
                                      //       Navigator.pushNamed(context, LOGIN_PAGE_INTRO);
                                      //
                                      //     }else{
                                      //       Navigator.pushNamed(context, BEACOME_SHEF_SLIDER_PAGE);
                                      //
                                      //     }
                                      //   },
                                      // ),

                                    ],
                                  ),

                                ) :
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:controller.list==null?0: controller.list!.length +
                                        (controller.feedPagingCirculer.value
                                            ? 1
                                            : 0),
                                    itemBuilder: (contex, index) {
                                      if (index < controller.list!.length) {
                                        return MenuCard(
                                          isLogin: homeController.token.value==""?false:true,
                                          feedId:controller.list![index].id,
                                          wishListed: controller.list![index].alreadyInWishList==null?false:controller.list![index].alreadyInWishList,
                                          menu: controller.list![index].menu!,
                                          chefId: controller.list![index].menu!
                                              .chef!.id,
                                          type: controller.list![index].menu!
                                              .type,
                                          createAt: controller.list![index]
                                              .createdAt,
                                          image: controller.list![index].menu!
                                              .images!,
                                          iteams: controller.list![index].menu!
                                              .menus!,
                                          title: controller.list![index].menu!
                                              .title,
                                          price: controller.list![index].menu!
                                              .price.toString(),
                                          chefName: controller.list![index]
                                              .menu!.chef!.name,
                                          chefPP: controller.list![index].menu!
                                              .chef!.profilePicture,
                                          deliveryInst: controller.list![index]
                                              .menu!.deliveryInstruction,
                                          orderInst: controller.list![index]
                                              .menu!.orderTakingInstruction,
                                          isDeliver: controller.list![index]
                                              .menu!.isDeliveryAvailable,
                                          isPickUp: controller.list![index]
                                              .menu!.isPickUpAvailable,
                                        );
                                      } else {
                                        Timer(const Duration(
                                            milliseconds: 30), () {
                                          controller.controller
                                              .jumpTo(
                                              controller.controller.position
                                                  .maxScrollExtent);
                                        });
                                        return const Center(
                                          child: CircularProgressIndicator(),);
                                      }
                                    }
                                )
                            ),
                          ],
                        )
                    ),
                  );
              });
            },
          );
        },
      ),
    );
  }

  Future<void> refreshList(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    getIt<LocationService>().getLocation();
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().onInit());
    Future.delayed(Duration.zero,()=>  Get.find<HomeController>().getShopList());
    Future.delayed(Duration.zero,()=>  Get.find<MenuControllerx>().getnewChef(true));
    Future.delayed(Duration.zero,()=>  Get.find<MenuControllerx>().getFeedMenu(Get.find<MenuControllerx>().homeFilterSelect, false));
  }
}
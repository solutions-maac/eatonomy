
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../GetX Controller/Chef/ChefController.dart';
import '../../../GetX Controller/Menu/MenuController.dart';
import '../../Widgets/Button/custom_button.dart';
import '../../Widgets/Loading/loading_widget.dart';
import '../../Widgets/TextField/text_field_reamarks.dart';
import '../Chef/Component/review.dart';
import 'Component/menu_card.dart';

class ChefHomeProfilePage extends StatelessWidget {
  final String?id;
  final bool?localUser;

  const ChefHomeProfilePage({Key? key, this.id, this.localUser=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,() => Get.find<ChefController>().getChefDetails(id!));

    return GetBuilder<ChefController>(
      assignId: true,
      builder: (chefController) {
        return Obx(() {
          return chefController.circuler.value||chefController.chefDetailsResponse.value==null ?
          Center(child: LoadingWidget(),) :
          Container(
            height: 1.0.sh,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24, top: 12),
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          children: [
                            Container(
                              height: 127,
                              decoration: ShapeDecoration(
                                color: Color(0xFFF1EDFC),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        chefController.chefDetailsResponse.value!.chef!.banner!
                                    ),
                                    fit: BoxFit.cover
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 100,
                              left: 0.35.sw,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF1EDFC),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        chefController.chefDetailsResponse.value!
                                            .chef!.profilePicture!),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                        width: 1.50, color: Colors.white),

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Text(
                        chefController.chefDetailsResponse.value!.chef!.name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF01180D),
                          fontSize: 18,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 28,),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    chefController.chefDetailsResponse.value!.totalWeeklyOrder.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF01180D),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.90,
                                    child: Text(
                                      'Weekly order completed',
                                      style: TextStyle(
                                        color: Color(0xFF01180D),
                                        fontSize: 12,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    chefController.chefDetailsResponse.value!.totalWeeklyOrder.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF01180D),
                                      fontSize: 18,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.90,
                                    child: Text(
                                      'Party order completed',
                                      style: TextStyle(
                                        color: Color(0xFF01180D),
                                        fontSize: 12,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),

                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 22,),
                      localUser!?
                      chefController.chefDetailsResponse.value!.chef!.isFollowed!?
                      SizedBox():
                      CustomButton(
                          height: 44,
                          orderRadius: 10,
                          color: kPrimaryColorx,
                          boder: true,
                          textColor: Colors.white,
                          title: "Follow Chef",
                          onTap: () {
                            chefController.followChef(id: id!);
                          }
                      ):CustomButton(
                          height: 44,
                          orderRadius: 10,
                          color: kPrimaryColorx,
                          boder: false,
                          textColor: Colors.white,
                          title: "Create Menu",
                          onTap: () {
                            Navigator.pushNamed(context, CREATE_MENU_PAGE,arguments: {
                              'id':id!
                            });
                          }
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 22,),
                Container(
                  width: 1.0.sw,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.38,
                        color: Color(0xB2D9D9D9),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                GetBuilder<MenuControllerx>(
                  assignId: true,
                  builder: (controller) {
                    return Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.menuSelect.value = "menu";
                                },
                                child: Container(
                                  width: 68,
                                  height: 32,
                                  margin: EdgeInsets.only(right: 8, left: 24),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: ShapeDecoration(
                                    color: controller.menuSelect == "menu"
                                        ? Color(0x2600934C)
                                        : Color(0x269EA0A2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Menu',
                                    style: TextStyle(
                                      color: controller.menuSelect == "menu"
                                          ? Color(0xFF00934C)
                                          : Color(0xFF9E9FA1),
                                      fontSize: 12,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap:(){
                                  controller.menuSelect.value="about";
                                },
                                child: Container(
                                  width: 68,
                                  height: 32,
                                  margin: EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: ShapeDecoration(
                                    color: controller.menuSelect == "about"
                                        ? Color(0x2600934C)
                                        : Color(0x269EA0A2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'About',
                                    style: TextStyle(
                                      color: controller.menuSelect == "about"
                                          ? Color(0xFF00934C)
                                          : Color(0xFF9E9FA1),
                                      fontSize: 12,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap:(){
                                  controller.menuSelect.value="rating";
                                },
                                child: Container(
                                  width: 68,
                                  height: 32,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  decoration: ShapeDecoration(
                                    color: controller.menuSelect == "rating"
                                        ? Color(0x2600934C)
                                        : Color(0x269EA0A2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Ratings',
                                    style: TextStyle(
                                      color: controller.menuSelect == "rating"
                                          ? Color(0xFF00934C)
                                          : Color(0xFF9E9FA1),
                                      fontSize: 12,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Container(
                            width: 1.0.sw,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.38,
                                  color: Color(0xB2D9D9D9),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          controller.menuSelect == "about"?
                          chefController.chefDetailsResponse.value!.chef!.about==null?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SalesCreateRemarkTextfield(
                                  readOnly: false,
                                  isNumber: false,
                                  hintText: "About",
                                  lable: "",
                                  controller: null,
                                  isValueChnged: true,
                                  tap: (text){
                                    if(text.isNotEmpty){
                                      chefController.about.value=text;
                                    }else{
                                      chefController.about.value="";
                                    }
                                  },
                                  maxLine: 10,
                                ),
                                SizedBox(height: 8,),
                                chefController.about.value!=""?
                                chefController.circleAbout.value?
                                LoadingWidget():
                                CustomButton(
                                    height: 48.h,
                                    orderRadius: 8,
                                    color: kPrimaryColorx,
                                    textColor: Colors.white,
                                    title: "Update",
                                    onTap: () {
                                      chefController.updateChefAbout(chefController.chefDetailsResponse.value!.chef!.id);
                                    }
                                ):SizedBox()
                              ],

                            ),
                          )
                              :
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(chefController.chefDetailsResponse.value!.chef!.about??""),
                          ):
                          controller.menuSelect == "rating" ?
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: chefController.chefDetailsResponse
                                .value!.reviews!.length,
                            itemBuilder: (context, index) {
                              return ReviewCrad(
                                review: chefController.chefDetailsResponse
                                    .value!.reviews![index],);
                            },
                          )
                              :
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: chefController.chefDetailsResponse.value!.menus!.length,
                            itemBuilder: (context,index){
                              return  MenuCard(
                                menu: chefController.chefDetailsResponse.value!.menus![index],
                                type:chefController.chefDetailsResponse.value!.menus![index].type ,
                                createAt: chefController.chefDetailsResponse.value!.menus![index].createdAt,
                                image: chefController.chefDetailsResponse.value!.menus![index].images!,
                                iteams: chefController.chefDetailsResponse.value!.menus![index].menus!,
                                title: chefController.chefDetailsResponse.value!.menus![index].title,
                                price: chefController.chefDetailsResponse.value!.menus![index].price.toString(),
                                chefName: chefController.chefDetailsResponse.value!.menus![index].chef!.name,
                                chefPP: chefController.chefDetailsResponse.value!.menus![index].chef!.profilePicture,
                                deliveryInst: chefController.chefDetailsResponse.value!.menus![index].deliveryInstruction,
                                orderInst: chefController.chefDetailsResponse.value!.menus![index].orderTakingInstruction,
                                isDeliver: chefController.chefDetailsResponse.value!.menus![index].isDeliveryAvailable,
                                isPickUp: chefController.chefDetailsResponse.value!.menus![index].isPickUpAvailable,
                              );
                            },
                          ),

                        ],
                      );
                    });
                  },
                )


              ],
            ),
          );
        });
      },
    );
  }
}


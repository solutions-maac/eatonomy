import 'dart:io';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';

import '../../../../Config/text_style.dart';
import '../../../../Constants/Colors/app_colors.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../GetX Controller/Chef/ChefController.dart';
import '../../../Widgets/Button/custom_button.dart';
import '../../../Widgets/Loading/loading_widget.dart';
import '../../../Widgets/TextField/bg_textfield.dart';

class BecomeChefProfilePage extends StatelessWidget {
  const BecomeChefProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Padding(
                padding: EdgeInsets.all(16),
                child: SvgPicture.asset("assets/icons/arrow-left.svg",height: 20,width: 20,))),
        title: Text('Profile',),
      ),
      backgroundColor: const Color(0XFFFFFFFF),
      body: GetBuilder<ChefController>(
        assignId: true,
        builder: (controller) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 18),
              height: 1.0.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your profile picture is one of the first things people see. try using your logo or simple image people can easily associate with you.',
                        style: TextStyle(
                          color: Color(0xFF5C6360),
                          fontSize: 13,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                      SizedBox(height: 16,),

                      Container(
                        height: 195,
                        child: Stack(
                          children: [
                           controller.imageUrl.value!=""?
                            Container(
                            height: 127,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: FileImage(controller.file!,),
                                fit: BoxFit.cover
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          )
                           :
                           Container(
                              height: 127,
                              decoration: ShapeDecoration(
                                color: Color(0xFFF2F2F2),
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
                              child:controller.ppImageUrl.value!=""?
                              Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: FileImage(controller.ppFile!,),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                        width: 1.50, color: Colors.white),

                                  ),
                                ),
                              )
                                  :
                              Container(
                                width: 80,
                                height: 80,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFEBEBEB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                        width: 1.50, color: Colors.white),

                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 80,
                                left: 0.75.sw,
                                child: InkWell(
                                  onTap: () {
                                    controller.filepic(true);
                                  },
                                  child:controller.ppCirculer.value||controller.coverCirculer.value?
                                  Container(
                                    width: 32,
                                    height: 32,
                                    padding: const EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: LoadingWidget(),
                                  )
                                  :
                                  Container(
                                    width: 32,
                                    height: 32,
                                    padding: const EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFEDFCEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/camera.svg",color: kPrimaryColor,),
                                  ),
                                )
                            ),
                            Positioned(
                                top: 150,
                                left: 0.49.sw,
                                child:controller.ppCirculer.value||controller.coverCirculer.value?
                                Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(4),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: LoadingWidget(),
                                )
                                :
                                InkWell(
                                  onTap: (){
                                    controller.filepic(false);
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(4),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFEDFCEF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/camera.svg",color: kPrimaryColor,),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Text(
                        controller.name.value??"",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF02190E),
                          fontSize: 18,
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                        ),

                      )

                    ],
                  ),
                 controller.circuler.value?LoadingWidget(): CustomButton(
                      height: 52,
                      orderRadius: 40,
                      color:controller.ppImageUrl.value==""||controller.imageUrl.value==""
                      ? Color(0xFFBCC3C0)
                      :
                      kPrimaryColorx,
                      boder: false,
                      textColor: Colors.white,
                      title: "Complete",
                      onTap: () {
                        if(controller.ppImageUrl.value!=""||controller.imageUrl.value!="")
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            // set this to true
                            shape: const RoundedRectangleBorder( // <-- SEE HERE
                              borderRadius: BorderRadius
                                  .vertical(
                                top: Radius.circular(40.0),
                              ),
                            ),

                            builder: (builder) {
                              return Container(
                                height: 420,
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  left: 14,
                                  right: 12,
                                  bottom: 12,
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20) ),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x338F6AF8),
                                      blurRadius: 16,
                                      offset: Offset(10, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/chefx.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12,),
                                    Text(
                                      'Welcome\nto your '+controller.name.value??"",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF02190E),
                                        fontSize: 20,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w700,
                                      ),

                                    ),
                                    SizedBox(height: 12,),
                                    Text(
                                      'Make it delicious, and grow your business',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5C6360),
                                        fontSize: 13,
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w400,

                                      ),
                                    ),
                                    SizedBox(height: 32,),
                                    CustomButton(
                                        height: 52,
                                        orderRadius: 40,
                                        color: kPrimaryColorx,
                                        boder: false,
                                        textColor: Colors.white,
                                        title: "Start",
                                        onTap: () {
                                          Logger().e( controller.name.value);
                                          Navigator.pop(context);
                                          controller.createChef(context);

                                        }
                                    ),
                                    SizedBox(height: 12,),
                                  ],
                                ),
                              );
                            });
                      }),

                ],
              ),
            );
          });
        },
      ),
    );
  }
}

